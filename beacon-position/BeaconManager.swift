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

    
    func eddystoneManager(_ manager: KTKEddystoneManager, didDiscover eddystones: Set<KTKEddystone>, in region: KTKEddystoneRegion?) {
        eddystones.forEach({(eddystone: KTKEddystone) in
            if !beacons.contains(eddystone) {
                beacons.append(eddystone)
            }
        })
    }
    
    func eddystoneManager(_ manager: KTKEddystoneManager, didUpdate eddystone: KTKEddystone, with frameType: KTKEddystoneFrameType) {
        if beacons.contains(eddystone) {
            if let index = beacons.index(of: eddystone) {
                beacons[index] = eddystone
            }
        }
    }
    
    //Starts Eddystone beacon discovery
    func start() {
        eddystoneManager.startEddystoneDiscovery(in: namespaceRegion)
    }
    
    //Stops Eddystone beacon discovery
    func stop() {
        eddystoneManager.stopEddystoneDiscoveryInAllRegions()
    }
    
    /*Creates a BeaconRangingSample based on the beacon information available (maybe move to separate class)
    * - todo: This function may have to enforce some sort of ordering on the different beacons
    */
    func createRangingSample() -> BeaconRangingSample {
        let rssiValues = beacons.map({ $0.rssi.intValue })
        return BeaconRangingSample(withRssiValues: rssiValues)
    }
    
    func appendRangingSample(toRoom room: Room) {
        let rssiValues = beacons.map({ $0.rssi.intValue })
        print(rssiValues)
        room.rangingSamples.append(BeaconRangingSample(withRssiValues: rssiValues))
        
    }
    
    
    
}

protocol BeaconDelegate {
    func beaconsChanged()
}

//A struct for holding a single beacon range measurement
struct BeaconRangingSample: CustomStringConvertible {
    
    private let timeStamp: NSDate
    private let values: [Int]
    var description: String {
        get {
            return "\(self.timeStamp.description): \(values.description) \n"
        }
    }
    
    //Initializer takes an array of integers that in our case
    init(withRssiValues values: [Int]) {
        timeStamp = NSDate()
        self.values = values
    }
    
    
}
