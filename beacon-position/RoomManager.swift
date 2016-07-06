//
//  RoomManager.swift
//  beacon-position
//
//  Created by Eirik Vikanes on 26/06/16.
//  Copyright © 2016 Eirik Vikanes. All rights reserved.
//

import Foundation


class RoomManager {
    
    var rooms = [Room]()
    
    init() {
        rooms.append(Room(withName: "Living room", forNumberOfBeacons: 4))
        rooms.append(Room(withName: "Bathroom", forNumberOfBeacons: 4))
        rooms.append(Room(withName: "Kitchen", forNumberOfBeacons: 4))
    }
}
