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
    var timer: Timer!
    
    var isProfiling = false {
        willSet {
            if newValue {
                profilingIndicator.startAnimating()
                profilingButton.setTitle("Stop Room Profiling", for: .normal)
                
            } else {
                profilingIndicator.stopAnimating()
                profilingButton.setTitle("Start Room Profiling", for: .normal)
            }
        }
    }
    
    // MARK: Outlets and Actions
    
    @IBOutlet weak var samplesTextView: UITextView!
    @IBOutlet weak var profilingButton: UIButton!
    @IBOutlet weak var profilingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    // Toggles the capture of beacon ranging samples, which are appended to this room's list of ranging samples
    @available(iOS 10.0, *)
    @IBAction func toggleProfiling(_ sender: UIButton) {
        if isProfiling {
            if (timer != nil) {
                timer.invalidate()
            }
            samplesTextView.text = room.description
            
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { _ in
                if let rangingSample = self.beaconManager.createRangingSample(forNumberOfBeacons: self.room.numberOfBeacons!) {
                    self.room.append(rangingSample: rangingSample)
                }
            })
        }
        isProfiling = !isProfiling
    }
    
    func beaconsChanged() {
        if(room.numberOfBeacons != nil) {
            profilingButton.isEnabled = beaconManager.beacons.count >= room.numberOfBeacons
        } 
    }
        
    // MARK: Lifecycle Events
    
    override func viewDidLoad() {
        nameLabel.text = room.name
        if room.numberOfBeacons == nil {
            profilingButton.isEnabled = true
        }
        beaconManager.delegate = self
        profilingIndicator.hidesWhenStopped = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        beaconManager.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        beaconManager.stop()
        if (timer != nil) {
            timer.invalidate()
        }
    }
}
