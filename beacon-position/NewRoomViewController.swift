//
//  NewRoomViewController.swift
//  beacon-position
//
//  Created by Eirik Vikanes on 06/07/16.
//  Copyright © 2016 Eirik Vikanes. All rights reserved.
//

import UIKit

class NewRoomViewController: UIViewController {
    
    private var count: Int! {
        willSet {
            beaconCountLabel.text = "\(newValue)"
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var beaconCountLabel: UILabel!
    var roomManager: RoomManager!
    
    
    @IBAction func countChanged(sender: UIStepper) {
        if sender.value < 0 {
            sender.value = 0
        }
        count = Int(sender.value)
    }
    
    
    @IBAction func save(sender: UIButton) {
        saveRoom()
        sender.enabled = false
    }
    
    
    func saveRoom() {
        if let name = nameTextField.text {
            roomManager.rooms.append(Room(withName: name, forNumberOfBeacons: count))
            print(roomManager.rooms)
        }
    }
    
    override func viewDidLoad() {
        count = 0
        
    }
    
    
    
    
}


