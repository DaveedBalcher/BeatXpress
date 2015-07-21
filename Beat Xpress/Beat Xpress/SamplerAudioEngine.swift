//
//  SamplerAudioEngine.swift
//  SimpleSample2
//
//  Created by Matthew Prockup on 6/25/15.
//  Copyright (c) 2015 Matthew Prockup. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

// The maximum number of audio buffers in flight. Setting to two allows one
// buffer to be played while the next is being written.
private let kInFlightAudioBuffers: Int = 2

// The number of audio samples per buffer. A lower value reduces latency for
// changes but requires more processing but increases the risk of being unable
// to fill the buffers in time. A setting of 1024 represents about 23ms of
// samples.
private let kSamplesPerBuffer: AVAudioFrameCount = 1024

class SamplerAudioEngine {
    
    // class definition goes here
    
    // The audio engine manages the sound system.
    private let engine: AVAudioEngine = AVAudioEngine()
    
    // The player node schedules the playback of the audio buffers.
    private let playerNode: AVAudioPlayerNode = AVAudioPlayerNode()
    
    // Use standard non-interleaved PCM audio. Stereo = 2 channels
    let audioFormat = AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 2)
    
    // A circular queue of audio buffers.
    private var audioBuffers: [AVAudioPCMBuffer] = [AVAudioPCMBuffer]()
    
    // The index of the next buffer to fill.
    private var bufferIndex: Int = 0
    
    // The dispatch queue to render audio samples.
    private let audioQueue: dispatch_queue_t = dispatch_queue_create("FMSynthesizerQueue", DISPATCH_QUEUE_SERIAL)
    
    // A semaphore to gate the number of buffers processed.
    private let audioSemaphore: dispatch_semaphore_t = dispatch_semaphore_create(kInFlightAudioBuffers)
    

    //dictionary of audio sample buffers for easy retrieval
    var samplesDict = [String:AVAudioBuffer]()

    
    // init session and create audio engine
    init() {
        // Create a pool of audio buffers.
        for var i = 0;  i < kInFlightAudioBuffers; i++ {
            let audioBuffer = AVAudioPCMBuffer(PCMFormat: audioFormat, frameCapacity: kSamplesPerBuffer)
            audioBuffer.frameLength = kSamplesPerBuffer
            audioBuffers.append(audioBuffer)
        }
        
        // Attach and connect the audio player node.
        engine.attachNode(playerNode)
        engine.connect(playerNode, to: engine.mainMixerNode, format: audioFormat)
        
        var error: NSError? = nil
        if !engine.startAndReturnError(&error) {
            NSLog("Error starting audio engine: \(error)")
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "audioEngineConfigurationChange:", name: AVAudioEngineConfigurationChangeNotification, object: engine)
    }
    
    //load an audio file into the sampler. Add it to the audio buffer dictionary.
    func addFile(fileName:String, key:String){
        
        //prepare audio file URL
        let inputString = fileName.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let fileURL = NSURL(string: inputString)
        println(fileURL)
        let tempAudioFile:AVAudioFile = AVAudioFile(forReading: fileURL, error: nil)
        let tempAudioFormat = tempAudioFile.processingFormat
        let tempAudioFrameCount = UInt32(tempAudioFile.length)
        
        //create buffer object from audio file
        var tempAudioBuffer = AVAudioPCMBuffer(PCMFormat: tempAudioFormat, frameCapacity: tempAudioFrameCount)
        
        //read the audio file and load it into the buffer
        var myError: NSError?
        tempAudioFile.readIntoBuffer(tempAudioBuffer, error:&myError)
        
        //add the buffer to the dictionary of samples
        samplesDict[key] = tempAudioBuffer
    }
    
    //start the audio session
    func startAudio(){
        
        dispatch_async(audioQueue) {
            
            //loop indefinately, should probobly add a flag here to stop/pause looping
            while true {
                // Wait for a buffer to become available.
                dispatch_semaphore_wait(self.audioSemaphore, DISPATCH_TIME_FOREVER)
                

                
                // Schedule the buffer for playback and reset it for reuse after
                // playback has finished.
                self.playerNode.scheduleBuffer(self.audioBuffers[self.bufferIndex]) {
                    
                    let leftChannel = self.audioBuffers[self.bufferIndex].floatChannelData[0]
                    let rightChannel = self.audioBuffers[self.bufferIndex].floatChannelData[1]
                    for var sampleIndex = 0; sampleIndex < Int(kSamplesPerBuffer); sampleIndex++ {
                        leftChannel[sampleIndex] = 0
                        rightChannel[sampleIndex] = 0
                    }
                    
                    dispatch_semaphore_signal(self.audioSemaphore)
                    return
                }
                
                //change to play the new buffer
                self.bufferIndex = (self.bufferIndex + 1) % self.audioBuffers.count
            }
        }
        
        // play the audio object
        playerNode.play()
    }
    
    //play a sample given a key
    func play(key:String)
    {
        self.play(key, gain: 1)
    }
    
    //play a sample given a key and gain
    func play(key:String, gain:Float)
    {
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            
            //get the sample data
            let numSamples = (self.samplesDict[key] as! AVAudioPCMBuffer).frameCapacity
            let leftData = (self.samplesDict[key] as! AVAudioPCMBuffer).floatChannelData[0]
            let rightData = (self.samplesDict[key] as! AVAudioPCMBuffer).floatChannelData[1]
            
            
            println("ADDING: \"\(key)\" sample to BUCKET. Its Length: \(numSamples)")
            
            var sampleCnt = 0
            var prevIndx = -1
            
            //loop until we've passed through entire audio file sample buffer
            while sampleCnt < Int(numSamples){
                
                // Wait for a buffer to become available. When it changes, there is an empty buffer (better way to do this?)
                var idx = self.bufferIndex
                while (idx == self.bufferIndex )                {
                    usleep(5000)
                }
                
                //get pointers to left and right channels of the circular buffer
                var leftOutput = self.audioBuffers[idx].floatChannelData[0]
                var rightOutput = self.audioBuffers[idx].floatChannelData[1]
                
                //fill buffer (sum to what is already there) kSamplesPerBuffer at a time
                for i in 0..<Int(kSamplesPerBuffer){
                    if(sampleCnt < Int(numSamples)){
                        leftOutput[i] += leftData[sampleCnt]*gain
                        if(abs(leftOutput[i]) > 1.0){
                            println("CLIPPING: \(abs(leftOutput[i]))")
                        }
                        
                        if (rightData != nil){
                            rightOutput[i] += rightData[sampleCnt]*gain
                            if(abs(rightOutput[i]) > 1.0){
                                println("CLIPPING \(abs(rightOutput[i]))")
                            }
                        }
                        else{
                            rightOutput[i] += leftData[sampleCnt]*gain
                            if(abs(rightOutput[i]) > 1.0){
                                println("CLIPPING \(abs(rightOutput[i]))")
                            }
                        }
                        
                        
                        sampleCnt++
                    }
                    
                }
            }
        }
    
    }
    
    @objc private func audioEngineConfigurationChange(notification: NSNotification) -> Void {
        NSLog("Audio engine configuration change: \(notification)")
    }
    
    
}
