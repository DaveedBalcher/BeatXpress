//
//  BeatCollectionViewController.swift
//  Beat Xpress
//
//  Created by Charles Burnett on 5/22/15.
//  Copyright (c) 2015 Charles Burnett. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class BeatCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var xae:SamplerAudioEngine!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //var defaultSampleList = [String]()
    //var strippedDefaultSampleArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        xae = SamplerAudioEngine()
        xae.startAudio()
        self.collectionView!.pagingEnabled = true;
        
        let fileManager = NSFileManager.defaultManager()
        
        var docPath = NSBundle.mainBundle().resourcePath!
        
        print(fileManager.fileExistsAtPath(docPath + "/Bright Crash" + "/Clamp" + "/MN_Bright Crash_Clamp_1114.4.wav"))

        xae.addFile(docPath + "/Bright Crash" + "/Clamp" + "/MN_Bright Crash_Clamp_1114.4.wav", key: "1")
        xae.addFile(docPath + "/Bright Crash" + "/Clamp" + "/MN_Bright Crash_Clamp_1114.4.wav", key: "2")
        xae.addFile(docPath + "/Bright Crash" + "/Tip" + "/MN_Bright Crash_Tip_1134.3.wav", key: "3")
        xae.addFile(docPath + "/Bright Crash" + "/Tip" + "/MN_Bright Crash_Tip_1112.4.wav", key: "4")
        xae.addFile(docPath +  "/Bright Crash" + "/Tip" + "/MN_Bright Crash_Tip_1112.3.wav", key: "4")
        
        xae.addFile(docPath + "/HiHat" + "/Pedal" + "/MN_HiHat_Pedal_1154.1.wav", key: "5")
        xae.addFile(docPath + "/HiHat" + "/Pedal" + "/MN_HiHat_Pedal_1154.2.wav", key: "6")
        xae.addFile(docPath + "/HiHat" + "/Pedal" + "/MN_HiHat_Pedal_1154.3.wav", key: "7")
        xae.addFile(docPath + "/HiHat" + "/Pedal" + "/MN_HiHat_Pedal_1154.4.wav", key: "8")
        xae.addFile(docPath + "/HiHat" + "/Tip" + "/MN_HiHat_Tip_1534.4.wav", key: "9")
        xae.addFile(docPath + "/HiHat" + "/Tip" + "/MN_HiHat_Tip_1523.4.wav", key: "10")
        xae.addFile(docPath + "/HiHat" + "/Tip" + "/MN_HiHat_Tip_1522.4.wav", key: "11")
        
        xae.addFile(docPath + "/Long Kick" + "/Press" + "/MN_Long Kick_Press_1115.6.wav", key: "12")
        xae.addFile(docPath + "/Long Kick" + "/Press" + "/MN_Long Kick_Press_1114.2.wav", key: "13")
        xae.addFile(docPath + "/Long Kick" + "/Press" + "/MN_Long Kick_Press_1113.6.wav", key: "14")
        xae.addFile(docPath + "/Long Kick" + "/Release" + "/MN_Long Kick_Release_1115.6.wav", key: "15")
        xae.addFile(docPath + "/Long Kick" + "/Release" + "/MN_Long Kick_Release_1114.6.wav", key: "16")
        xae.addFile(docPath + "/Long Kick" + "/Release" + "/MN_Long Kick_Release_1113.6.wav", key: "17")
        
        xae.addFile(docPath + "/Snare" + "/Buzz" + "/MN_Snare_Buzz_1334.4.wav", key: "18")
        xae.addFile(docPath + "/Snare" + "/Buzz" + "/MN_Snare_Buzz_1324.4.wav", key: "19")
        xae.addFile(docPath + "/Snare" + "/Buzz" + "/MN_Snare_Buzz_1111.4.wav", key: "20")
        xae.addFile(docPath + "/Snare" + "/Buzz" + "/MN_Snare_Buzz_1114.4.wav", key: "21")
        xae.addFile(docPath + "/Snare" + "/Cross Stick" + "/MN_Snare_Cross Stick_1324.4.wav", key: "22")
        xae.addFile(docPath + "/Snare" + "/Cross Stick" + "/MN_Snare_Cross Stick_1314.4.wav", key: "23")
        xae.addFile(docPath + "/Snare" + "/Cross Stick" + "/MN_Snare_Cross Stick_1224.4.wav", key: "24")
        xae.addFile(docPath + "/Snare" + "/Cross Stick" + "/MN_Snare_Cross Stick_1114.4.wav", key: "25")
        xae.addFile(docPath + "/Snare" + "/Rim" + "/MN_Snare_Rim_1324.4.wav", key: "26")
        xae.addFile(docPath + "/Snare" + "/Rim" + "/MN_Snare_Rim_1313.4.wav", key: "27")
        xae.addFile(docPath + "/Snare" + "/Rim" + "/MN_Snare_Rim_1223.4.wav", key: "28")
        xae.addFile(docPath + "/Snare" + "/Strike" + "/MN_Snare_Strike_1324.4.wav", key: "29")
        xae.addFile(docPath + "/Snare" + "/Strike" + "/MN_Snare_Strike_1322.4.wav", key: "30")
        xae.addFile(docPath + "/Snare" + "/Strike" + "/MN_Snare_Strike_1114.4.wav", key: "31")
        xae.addFile(docPath + "/Snare" + "/Strike" + "/MN_Snare_Strike_1123.4.wav", key: "32")
        
        //println(defaultSampleList.count)
        /*
        for filename in defaultSampleList
        {
            let strippedFileName = substringInRange(filename, start: 0, end: count(filename)-4)
            strippedDefaultSampleArray.append(strippedFileName)
        }
        */
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        
        return 35
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        cell.layer.cornerRadius = 5
        
        // Configure the cell
    
        return cell
    }
    /*
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(90, 90)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 10
    }
    */

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // You can use indexPath to get "cell number x", key: or get the cell like:
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        xae.play(String(indexPath.row+1))
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath){
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
    }

    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.backgroundColor = UIColor.blueColor()
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.backgroundColor = UIColor(red: 30/255, green: 43/255, blue: 103/255, alpha: 1)
    }
    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    
    // Uncomment this method to specify if the specified item should be selected
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        self.printThatItWorked()
    }
    */
    
    func substringInRange(original:String, start:Int, end:Int)->String
    {
        let newString = original [ advance(original.startIndex,start) ..< advance(original.startIndex,end)]
        return newString
    }
    
    func substringIterate(original:String, start:Int, move:Int)->String
    {
        let newString = original [ advance(original.startIndex,start) ..< advance(original.startIndex,start+move)]
        return newString
    }

}
