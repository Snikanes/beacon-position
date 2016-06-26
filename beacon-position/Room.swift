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
    
    //Initializer takes the name of the room, and initalizes an empty array
    init(withName name: String) {
        self.name = name
        rangingSamples = Array<BeaconRangingSample>()
        
    }
    
    //Convenience initializer for use cases where we already have ranging samples
    
    convenience init(withName name: String, withRangingSamples rangingSamples: Array<BeaconRangingSample>) {
        self.init(withName: name)
        self.rangingSamples = rangingSamples
    }
    
    
    
    
    
    
    
    
    
    
}