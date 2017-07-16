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
    private static let hpGain: Double = 20
    private static let hpRegenGain: Double = 0.03
    private static let manaGain: Double = 12
    private static let manaRegenGain: Double = 0.04
    private static let spellDamageGain: Double = 1/15
    private static let armourGain: Double = 1/7
    
    public weak var delegate: HeroDelegate?
    
    // properties
    public var level: Int = 1 {
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
    public lazy var primaryAttribute: Attribute = {[unowned self] in
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
    public var armour: Double { return base.armor + agility * Hero.armourGain }
    public var attackPerSecond: Double { return (100 + agility) * 0.01 / misc.baseAttackTime }
    public var hp: Double { return base.hp + strength * Hero.hpGain }
    public var hpRegen: Double { return base.hpRegen + strength * Hero.hpRegenGain }
    public var mana: Double { return base.mana + intelligence * Hero.manaGain }
    public var manaRegen: Double { return base.manaRegen + intelligence * Hero.manaRegenGain }
    public var damage: (min: Double, max: Double) {
        let increment = valueFor(attribute: primaryAttribute)
        return (base.minDamage + increment, base.maxDamage + increment)
    }
    public var spellDamage: Double { return base.spellDamage + intelligence * Hero.spellDamageGain }
    
    // Misc Stats
    public var attackAnimation: String { return misc.attackAnimation }
    public var attackRange: Double { return misc.attackRange }
    public var baseAttackTime: Double { return misc.baseAttackTime }
    public var collisionSize: Double { return misc.collisionSize }
    public var magicResistance: Double { return misc.magicResistance }
    public var movementSpeed: Double { return misc.movementSpeed }
    public var projectileSpeed: Double { return misc.projectileSpeed }
    public var turnRate: Double { return misc.turnRate }
    public var visionRange: String { return misc.visionRange }
    
    // Dictionary for data (mainly to make tableview data easier to present
    // This isn't really proper but it makes life infinitely better
    var dataDictionary: [String: [String: String]] {
        return
            [
                "Stats":
                    [
                        "Armour": armour.uti_string(2),
                        "Attack/s": attackPerSecond.uti_string(2),
                        "HP": hp.uti_string(0),
                        "HP Regen": hpRegen.uti_string(2),
                        "Mana": mana.uti_string(0),
                        "Mana Regen": manaRegen.uti_string(2),
                        "Damage": damage.min.uti_string(0) + "-" + damage.max.uti_string(0),
                        "Spell Damage": spellDamage.uti_string(2) + "%"
                    ],
                "Misc":
                    [
                        "Attack Animation": attackAnimation,
                        "Attack Range": attackRange.uti_string(0),
                        "Base Attack Time": baseAttackTime.uti_string(1),
                        "Collision Size": collisionSize.uti_string(0),
                        "Magic Resistance": magicResistance.uti_string(0) + "%",
                        "Movement Speed": movementSpeed.uti_string(0),
                        "Projectile Speed": projectileSpeed == 0 ? "Instant" : projectileSpeed.uti_string(0),
                        "Turn Rate": turnRate.uti_string(0),
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
        return base + increment * (level - 1).uti_doubleValue
    }
    
}
