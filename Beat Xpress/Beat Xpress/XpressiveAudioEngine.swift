//
//  XpressiveAudioEngine.swift
//  Beat Xpress
//
//  Created by Charles Burnett on 5/21/15.
//  Copyright (c) 2015 Charles Burnett. All rights reserved.
//

import UIKit
import AVFoundation

class XpressiveAudioEngine: NSObject {
    
    var audioPlayer = AVAudioPlayer()
    
    func XpressiveAudioEngine()
    {
        
    }
    
    func playSample(sampleName: String)
    {
        println(sampleName)
        var error:NSError?
        let path = NSBundle.mainBundle().pathForResource(sampleName, ofType: "wav")
        
        let url = NSURL(fileURLWithPath: path!)
        
        println(url)
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)

        self.audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        self.audioPlayer.prepareToPlay()
        self.audioPlayer.play()
    }
    
}
