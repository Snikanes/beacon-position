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
        rooms.append(Room(withName: "Living room"))
        rooms.append(Room(withName: "Bathroom"))
        rooms.append(Room(withName: "Kitchen"))
        rooms.forEach( {print($0.name)} )
    }
}
