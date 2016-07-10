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
    
    /* Creates a BeaconRangingSample based on the beacon information available (maybe move to separate class)
    * - todo: This function may have to enforce some sort of ordering on the different beacons
    */
    func createRangingSample() -> BeaconRangingSample {
        let IDsAndRssiValues = beacons.map({ ($0.identifier.uuidString, $0.rssi.intValue) })
        return BeaconRangingSample(withIDsAndRssiValues: IDsAndRssiValues)
    }
}

protocol BeaconDelegate {
    func beaconsChanged()
}

//A struct for holding a single beacon ranging sample
struct BeaconRangingSample: CustomStringConvertible {
    
    private let values: [(String,Int)]
    
    var beaconCount: Int {
        get {
            return values.count
        }
    }
    
    var description: String {
        get {
            return "\(values) \n"
        }
    }
    
    //Initializer takes an array of integers that in our case
    init(withIDsAndRssiValues values: [(String, Int)]) {
        self.values = values.sorted(isOrderedBefore: { $0.0 > $1.0 })
    }
    
    
}
