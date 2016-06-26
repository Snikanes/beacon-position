//
//  BeaconRangeFinder.swift
//  beacon-position
//
//  Created by Eirik Vikanes on 26/06/16.
//  Copyright © 2016 Eirik Vikanes. All rights reserved.
//

import Foundation
import KontaktSDK
import CoreBluetooth

class BeaconManager: NSObject, KTKEddystoneManagerDelegate {
    
    //Array is a struct, so we can safely expose the beacons without breaking encapsulation
    var beacons = [KTKEddystone]() {
        didSet {
            if delegate != nil {
                delegate!.beaconsChanged()
            }
        }
    }
    
    private lazy var eddystoneManager: KTKEddystoneManager = { KTKEddystoneManager(delegate: self) }()
    private var namespaceRegion = KTKEddystoneRegion(namespaceID: "f7826da6bc5b71e0893e")
    var delegate: BeaconDelegate?

    
    func eddystoneManager(manager: KTKEddystoneManager, didDiscoverEddystones eddystones: Set<KTKEddystone>, inRegion region: KTKEddystoneRegion?) {
        eddystones.forEach({(eddystone: KTKEddystone) in
            if !beacons.contains(eddystone) {
                beacons.append(eddystone)
            }
        })
    }
    
    func eddystoneManager(manager: KTKEddystoneManager, didUpdateEddystone eddystone: KTKEddystone, withFrame frameType: KTKEddystoneFrameType) {
        if beacons.contains(eddystone) {
            if let index = beacons.indexOf(eddystone) {
                beacons[index] = eddystone
            }
        }
    }
    
    func start() {
        eddystoneManager.startEddystoneDiscoveryInRegion(namespaceRegion)
    }
    
    func stop() {
        eddystoneManager.stopEddystoneDiscoveryInAllRegions()
    }
}

protocol BeaconDelegate {
    func beaconsChanged()
}