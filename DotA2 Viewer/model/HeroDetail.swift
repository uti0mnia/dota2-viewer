//
//  HeroDetail.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-04-11.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData

class HeroDetail {
    // some static constants
    static fileprivate var HP_GAIN: NSNumber = 20
    static fileprivate var HP_REGEN_GAIN: NSNumber = 0.03
    static fileprivate var MANA_GAIN: NSNumber = 12
    static fileprivate var MANA_REGEN_GAIN: NSNumber = 0.04
    static fileprivate var SPELL_DAMAGE_GAIN: NSNumber = NSNumber(floatLiteral: 1/15)
    static fileprivate var ARMOUR_GAIN: NSNumber = NSNumber(floatLiteral: 1/7)
    
    // properties
    var hero: Hero!
    var level: Int {
        get { return self.level }
        set(value) {
            if (value < 1) { self.level = 1 }
            else if (value > 25) { self.level = 25}
            else { self.level = value }
        }
    }
    
    init(hero: Hero) {
        self.hero = hero
        self.level = 1
    }
}
