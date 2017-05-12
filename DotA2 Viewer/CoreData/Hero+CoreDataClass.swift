//
//  Hero+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData
import UIKit


public class Hero: Object {
    // some static constants
    static fileprivate var HP_GAIN: Double = 20
    static fileprivate var HP_REGEN_GAIN: Double = 0.03
    static fileprivate var MANA_GAIN: Double = 12
    static fileprivate var MANA_REGEN_GAIN: Double = 0.04
    static fileprivate var SPELL_DAMAGE_GAIN: Double = 1/15
    static fileprivate var ARMOUR_GAIN: Double = 1/7
    
    // properties
    var level: Int {
        get { return self.level }
        set(value) {
            if (value < 1) { self.level = 1 }
            else if (value > 25) { self.level = 25}
            else { self.level = value }
        }
    }
    lazy var primaryAttribute: Attribute = {[unowned self] in
        return (self.attributes.array as! [Attribute]).first(where: { $0.isPrimary })!
    }()
    
    // values that change based on level
    var intelligence: Double { get { return valueFor(attribute: attributes.object(at: 0) as! Attribute) } }
    var agility: Double { get { return valueFor(attribute: attributes.object(at: 1) as! Attribute) } }
    var strength: Double { get { return valueFor(attribute: attributes.object(at: 2) as! Attribute) } }
    var armour: Double { get { return base.armor + agility / 7 } }
    var damage: (min: Double, max: Double) {
        get {
            let increment = valueFor(attribute: primaryAttribute)
            return (base.minDamage + increment, base.maxDamage + increment)
        }
    }
    var hp: Double { get { return base.hp + strength * Hero.HP_GAIN } }
    var hpRegen: Double { get { return base.hpRegen + strength * Hero.HP_REGEN_GAIN } }
    var mana: Double { get { return base.mana + intelligence * Hero.MANA_GAIN } }
    var manaRegen: Double { get { return base.manaRegen + intelligence * Hero.MANA_REGEN_GAIN } }
    var spellDamage: Double { get { return base.spellDamage + intelligence * Hero.SPELL_DAMAGE_GAIN } }
    var attackPerSecond: Double { get { return (100 + agility) * 0.01 / misc.baseAttackTime } }
    
    func valueFor(attribute: Attribute) -> Double{
        let base = attribute.base
        let increment = attribute.increment
        return base + increment * (level - 1).doubleValue
    }
    
}
