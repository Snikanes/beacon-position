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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! BeaconTableViewCell
        let beacon = beaconManager.beacons[indexPath.row]
        cell.identifierTextField.text = "\(beacon.eddystoneUID!.instanceID)"
        cell.rssiTextField.text = "\(beacon.rssi)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return beaconManager.beacons.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
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
    
    override func viewWillAppear(_ animated: Bool) {
        beaconManager.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        beaconManager.stop()
    }
}

