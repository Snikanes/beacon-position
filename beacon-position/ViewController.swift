//
//  ViewController.swift
//  beacon-position
//
//  Created by Eirik Vikanes on 25/06/16.
//  Copyright © 2016 Eirik Vikanes. All rights reserved.
//

import UIKit
import KontaktSDK
import CoreBluetooth

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, KTKEddystoneManagerDelegate {
    
    //The Core Bluetooth manager
    private let cellIdentifier = "peripheralCell"
    
    private var eddystoneManager: KTKEddystoneManager!
    private var namespaceRegion: KTKEddystoneRegion!
    private var domainRegion: KTKEddystoneRegion!
    private var secureNamespaceRegion: KTKSecureEddystoneRegion!
    
    
    @IBOutlet weak var peripheralTable: UITableView!
    
    
    //A dictionary holding the peripherals (beacons) we have seen
    private var peripherals = [KTKEddystone]() {
        didSet {
            peripheralTable.reloadData()
        }
    }
    
    @IBAction func startScan(sender: UIButton) {
        
    }
    
    @IBOutlet weak var testField: UITextView!
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PeripheralTableViewCell
        let peripheral = peripherals[indexPath.row]
        cell.identifierTextField.text = "\(peripheral.eddystoneUID)"
        cell.rssiTextField.text = "\(peripheral.RSSI)"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func eddystoneManager(manager: KTKEddystoneManager, didDiscoverEddystones eddystones: Set<KTKEddystone>, inRegion region: KTKEddystoneRegion?) {
        eddystones.forEach({(eddystone: KTKEddystone) in
            if !peripherals.contains(eddystone) {
                peripherals.append(eddystone)
            }
        })
    }
    
    func eddystoneManager(manager: KTKEddystoneManager, didUpdateEddystone eddystone: KTKEddystone, withFrame frameType: KTKEddystoneFrameType) {
        if peripherals.contains(eddystone) {
            if let index = peripherals.indexOf(eddystone) {
                peripherals[index] = eddystone
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        peripheralTable.delegate = self
        peripheralTable.dataSource = self
        eddystoneManager = KTKEddystoneManager(delegate: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        namespaceRegion = KTKEddystoneRegion(namespaceID: "f7826da6bc5b71e0893e")
        eddystoneManager.startEddystoneDiscoveryInRegion(namespaceRegion)
    }
    
    override func viewWillDisappear(animated: Bool) {
        eddystoneManager.stopEddystoneDiscoveryInAllRegions()
    }
}

