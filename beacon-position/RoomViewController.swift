//
//  RoomViewController.swift
//  beacon-position
//
//  Created by Eirik Vikanes on 26/06/16.
//  Copyright © 2016 Eirik Vikanes. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var roomTableView: UITableView!
    private let cellIdentifier = "roomCell"
    private var roomManager = RoomManager()
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RoomTableViewCell
        let room = roomManager.rooms[indexPath.row]
        cell.nameLabel.text = room.name
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomManager.rooms.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomTableView.delegate = self
        roomTableView.dataSource = self
        print(roomManager.rooms)
    }

    @IBAction func addRoom(sender: UIBarButtonItem) {
        roomTableView.reloadData()
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
