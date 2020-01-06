//
//  HeroState.swift
//  MVI-Swift
//
//  Created by Marcel Kulina on 06.01.20.
//  Copyright © 2020 Broken Bytes. All rights reserved.
//

import Foundation

class HeroState {
    class HeroPresenting: HeroState {
        let hero: Hero
        let nextAvailable: Bool
        let previousAvailable: Bool

        
        init(withHero hero: Hero, nextAvailable next: Bool, previousAvailable previous: Bool) {
            self.hero = hero
            self.nextAvailable = next
            self.previousAvailable = previous
        }
    }
    
    class HeroSelected: HeroState {
        let hero: Hero
        
        init(selectedHero hero: Hero) {
            self.hero = hero
        }
    }
}
