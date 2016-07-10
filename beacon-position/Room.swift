//
//  Room.swift
//  beacon-position
//
//  Created by Eirik Vikanes on 26/06/16.
//  Copyright © 2016 Eirik Vikanes. All rights reserved.
//

import Foundation

class Room {
    
    var name: String
    var rangingSamples: Array<BeaconRangingSample>!
    var numberOfBeacons: Int?
    
    // Initializer takes the name of the room and a specified number of beacons, and initalizes an empty array
    init(withName name: String, forNumberOfBeacons numberOfBeacons: Int?) {
        self.name = name
        self.numberOfBeacons = numberOfBeacons
        rangingSamples = Array<BeaconRangingSample>()
    }
    
    // Convenience initializer for use cases where we already have ranging samples
    convenience init(withName name: String, forNumberOfBeacons numberOfBeacons: Int, withRangingSamples rangingSamples: Array<BeaconRangingSample>) {
        self.init(withName: name, forNumberOfBeacons: numberOfBeacons)
        self.rangingSamples = rangingSamples
    }
    
    // Appends a beacon ranging sample to this room's rangingSamples.
    // Samples that have fewer beacon measurements than required are discarded
    func append(rangingSample sample: BeaconRangingSample) {
        rangingSamples.append(sample)
    }
}
