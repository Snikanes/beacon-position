//
//  ViewController.swift
//  beacon-position
//
//  Created by Eirik Vikanes on 25/06/16.
//  Copyright © 2016 Eirik Vikanes. All rights reserved.
//

import UIKit


class BeaconTableViewController: UITableViewController, BeaconDelegate {
    
    private let cellIdentifier = "beaconCell"
    private var beaconManager = BeaconManager()

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BeaconTableViewCell
        let beacon = beaconManager.beacons[indexPath.row]
        cell.identifierTextField.text = "\(beacon.eddystoneUID!)"
        cell.rssiTextField.text = "\(beacon.RSSI)"
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beaconManager.beacons.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func beaconsChanged() {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beaconManager.delegate = self
        tableView.contentInset.top = 20
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        beaconManager.start()
    }
    
    override func viewWillDisappear(animated: Bool) {
        beaconManager.stop()
    }
}

