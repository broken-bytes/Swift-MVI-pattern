//
//  Character.swift
//  MVI-Swift
//
//  Created by Marcel Kulina on 06.01.20.
//  Copyright © 2020 Broken Bytes. All rights reserved.
//

import Foundation

class Hero {
    let name: String
    let speed: Float
    let power: Float
    let stamina: Float
    
    init(_ name: String, speed: Float, power: Float, stamina: Float) {
        self.name = name
        self.speed = speed
        self.power = power
        self.stamina = stamina
    }
}
