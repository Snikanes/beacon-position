//
//  RoomViewController.swift
//  beacon-position
//
//  Created by Eirik Vikanes on 26/06/16.
//  Copyright © 2016 Eirik Vikanes. All rights reserved.
//

import UIKit

class RoomTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var roomTableView: UITableView!
    private let cellIdentifier = "roomCell"
    private var roomManager = RoomManager() // TODO: Make into a singleton
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! RoomTableViewCell
        let room = roomManager.rooms[indexPath.row]
        cell.nameLabel.text = room.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomManager.rooms.count
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomTableView.delegate = self
        roomTableView.dataSource = self
        //print(roomManager.rooms)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        roomTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
                
            case "Show Room":
                if let index = roomTableView.indexPath(for : (sender as? RoomTableViewCell)!) {
                    if let vc = segue.destinationViewController as? RoomViewController {
                        vc.room = roomManager.rooms[index.row]
                        vc.beaconManager = BeaconManager()
                    }
                }
                
            case "New Room":
                if let vc = segue.destinationViewController as? NewRoomViewController {
                    vc.roomManager = self.roomManager
                }
            
            default:
                break
                
            }
        }
    }
}
