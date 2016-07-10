//
//  NewRoomViewController.swift
//  beacon-position
//
//  Created by Eirik Vikanes on 06/07/16.
//  Copyright © 2016 Eirik Vikanes. All rights reserved.
//

import UIKit

class NewRoomViewController: UIViewController, UINavigationBarDelegate {
    
    private var count: Int! {
        willSet {
            beaconCountLabel.text = "\(newValue)"
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var beaconCountLabel: UILabel!
    var roomManager: RoomManager!
    
    @IBAction func countChanged(_ sender: UIStepper) {
        if sender.value < 0 {
            sender.value = 0
        }
        count = Int(sender.value)
    }
    
    private func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
    //Validation needs to be added
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        saveRoom()
        cancel(sender)
    }
    
    func saveRoom() {
        if let name = nameTextField.text {
            roomManager.rooms.append(Room(withName: name, forNumberOfBeacons: count))
            print(roomManager.rooms)
        }
    }
    
    override func viewDidLoad() {
        count = 0
        navBar.delegate = self
    }
}

