//
//  ViewController.swift
//  Beat Xpress
//
//  Created by Charles Burnett on 5/21/15.
//  Copyright (c) 2015 Charles Burnett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var xae = XpressiveAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func snarePressed(sender: AnyObject) {
        xae.playSample("Snare/Strike/MN_Snare_Strike_1111.1")
    }

    @IBAction func hiHatPressed(sender: AnyObject) {
    }
    @IBAction func kickPressed(sender: AnyObject) {
    }
}

