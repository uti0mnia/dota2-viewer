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
    static private let HP_GAIN: Double = 20
    static private let HP_REGEN_GAIN: Double = 0.03
    static private let MANA_GAIN: Double = 12
    static private let MANA_REGEN_GAIN: Double = 0.04
    static private let SPELL_DAMAGE_GAIN: Double = 1/15
    static private let ARMOUR_GAIN: Double = 1/7
    
    weak var delegate: HeroDelegate?
    
    // properties
    var level: Int = 1 {
        didSet {
            if self.level < 1 {
                self.level = 1
            }
            else if self.level > 25 {
                self.level = 25
            }
            delegate?.heroDidUpdateLevel()
        }
    }
    lazy var primaryAttribute: Attribute = {[unowned self] in
        return (self.attributes.array as! [Attribute]).first(where: { $0.isPrimary })!
    }()
    
    // attributes
    public var intelligence: Double { return valueFor(attribute: attributes.object(at: 0) as! Attribute) }
    public var intelligenceGain: Double { return (attributes.object(at: 0) as! Attribute).increment }
    public var agility: Double { return valueFor(attribute: attributes.object(at: 1) as! Attribute) }
    public var agilityGain: Double { return (attributes.object(at: 1) as! Attribute).increment }
    public var strength: Double { return valueFor(attribute: attributes.object(at: 2) as! Attribute) }
    public var strengthGain: Double { return (attributes.object(at: 2) as! Attribute).increment }
    
    // Base stats
    private var armour: Double { return base.armor + agility / 7 }
    private var attackPerSecond: Double { return (100 + agility) * 0.01 / misc.baseAttackTime }
    private var hp: Double { return base.hp + strength * Hero.HP_GAIN }
    private var hpRegen: Double { return base.hpRegen + strength * Hero.HP_REGEN_GAIN }
    private var mana: Double { return base.mana + intelligence * Hero.MANA_GAIN }
    private var manaRegen: Double { return base.manaRegen + intelligence * Hero.MANA_REGEN_GAIN }
    private var damage: (min: Double, max: Double) {
        let increment = valueFor(attribute: primaryAttribute)
        return (base.minDamage + increment, base.maxDamage + increment)
    }
    private var spellDamage: Double { return base.spellDamage + intelligence * Hero.SPELL_DAMAGE_GAIN }
    
    // Misc Stats
    private var attackAnimation: String { return misc.attackAnimation }
    private var attackRange: Double { return misc.attackRange }
    private var baseAttackTime: Double { return misc.baseAttackTime }
    private var collisionSize: Double { return misc.collisionSize }
    private var magicResistance: Double { return misc.magicResistance }
    private var movementSpeed: Double { return misc.movementSpeed }
    private var projectileSpeed: Double { return misc.projectileSpeed }
    private var turnRate: Double { return misc.turnRate }
    private var visionRange: String { return misc.visionRange }
    
    // Dictionary for data (mainly to make tableview data easier to present
    // This isn't really proper but it makes life infinitely better
    var dataDictionary: [String: [String: String]] {
        return
            [
                "Stats":
                    [
                        "Armour": armour.u0_string(2),
                        "Attack/s": attackPerSecond.u0_string(2),
                        "HP": hp.u0_string(0),
                        "HP Regen": hpRegen.u0_string(2),
                        "Mana": mana.u0_string(0),
                        "Mana Regen": manaRegen.u0_string(2),
                        "Damage": damage.min.u0_string(0) + "-" + damage.max.u0_string(0),
                        "Spell Damage": spellDamage.u0_string(2) + "%"
                    ],
                "Misc":
                    [
                        "Attack Animation": attackAnimation,
                        "Attack Range": attackRange.u0_string(0),
                        "Base Attack Time": baseAttackTime.u0_string(1),
                        "Collision Size": collisionSize.u0_string(0),
                        "Magic Resistance": magicResistance.u0_string(0) + "%",
                        "Movement Speed": movementSpeed.u0_string(0),
                        "Projectile Speed": projectileSpeed == 0 ? "Instant" : projectileSpeed.u0_string(0),
                        "Turn Rate": turnRate.u0_string(0),
                        "Vision Range": visionRange
                    ]
            ]
    }
    var miscDictionary: [String: String] {
        return
            [
                "Lore": lore,
                "Description": descript
            ]
    }
    
    private func valueFor(attribute: Attribute) -> Double {
        let base = attribute.base
        let increment = attribute.increment
        return base + increment * (level - 1).u0_doubleValue
    }
    
}
