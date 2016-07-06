//
//  NewRoomViewController.swift
//  beacon-position
//
//  Created by Eirik Vikanes on 30/06/16.
//  Copyright © 2016 Eirik Vikanes. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController, BeaconDelegate {
    
    // MARK: Instance variables
    
    var room: Room!
    var beaconManager = BeaconManager()
    var timer: NSTimer?
    
    var profiling = false {
        willSet {
            if newValue {
                profilingIndicator.startAnimating()
                profilingButton.setTitle("Start Room Profiling", forState: .Normal)
                
            } else {
                profilingIndicator.stopAnimating()
                profilingButton.setTitle("Stop Room Profiling", forState: .Normal)
            }
        }
    }
    
    // MARK: Outlets and Actions
    
    @IBOutlet weak var samplesTextView: UITextView!
    @IBOutlet weak var profilingButton: UIButton!
    @IBOutlet weak var profilingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func toggleProfiling(sender: UIButton) {
        if profiling {
            if timer != nil {
                timer!.invalidate()
                timer = nil
            }
            samplesTextView.text = room.rangingSamples.description
            
        } else {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(RoomViewController.appendSample), userInfo: nil, repeats: true)
        }
        profiling = !profiling

    }
    
    func appendSample() {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
            self.beaconManager.appendRangingSample(toRoom: self.room)
        })
    }
    
    func beaconsChanged() {
        if(room.numberOfBeacons != nil) {
            profilingButton.enabled = beaconManager.beacons.count >= room.numberOfBeacons
        }
    }
    
    
    
    
    // MARK: Lifecycle Events
    
    override func viewDidLoad() {
        nameLabel.text = room.name
        if room.numberOfBeacons == nil {
            profilingButton.enabled = true
        }
        beaconManager.delegate = self
        profilingIndicator.hidesWhenStopped = true
    }
    
    override func viewWillAppear(animated: Bool) {
        beaconManager.start()
    }
    
    override func viewWillDisappear(animated: Bool) {
        beaconManager.stop()
        if(timer != nil) {
            timer!.invalidate()
            timer = nil
        }
    }

}
