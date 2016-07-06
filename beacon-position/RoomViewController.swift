//
//  NewRoomViewController.swift
//  beacon-position
//
//  Created by Eirik Vikanes on 30/06/16.
//  Copyright © 2016 Eirik Vikanes. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {
    
    var room: Room!
    var beaconManager: BeaconManager!
    var profiling = false
    var timer: NSTimer?
    
    var stoppedText = "Start Room Profiling"
    var startedText = "Stop Room Profiling"
    
    @IBOutlet weak var samplesTextView: UITextView!
    @IBOutlet weak var profilingButton: UIButton!
    @IBOutlet weak var profilingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func toggleProfiling(sender: UIButton) {
        if profiling {
            profilingIndicator.stopAnimating()
            profilingButton.setTitle(stoppedText, forState: .Normal)
            
            if timer != nil {
                timer!.invalidate()
                timer = nil
            }
            
            samplesTextView.text = room.rangingSamples.description
            
        } else {
            profilingIndicator.startAnimating()
            profilingButton.setTitle(startedText, forState: .Normal)
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(RoomViewController.appendSample), userInfo: nil, repeats: true)
        }
        profiling = !profiling

    }
    
    func appendSample() {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
            self.beaconManager.appendRangingSample(toRoom: self.room)
        })
    }
    
    
    override func viewDidLoad() {
        nameLabel.text = room.name
        profilingIndicator.hidesWhenStopped = true
    }
    
    override func viewWillAppear(animated: Bool) {
        beaconManager.start()
    }
    
    override func viewWillDisappear(animated: Bool) {
        beaconManager.stop()
    }

}
