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
    var intelligence: Double { return valueFor(attribute: attributes.object(at: 0) as! Attribute) }
    var agility: Double { return valueFor(attribute: attributes.object(at: 1) as! Attribute) }
    var strength: Double { return valueFor(attribute: attributes.object(at: 2) as! Attribute) }
    
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
                        "Armour": armour.string(2),
                        "Attack/s": attackPerSecond.string(2),
                        "HP": hp.string(0),
                        "HP Regen": hpRegen.string(2),
                        "Mana": mana.string(0),
                        "Mana Regen": manaRegen.string(2),
                        "Damage": damage.min.string(0) + "-" + damage.max.string(0),
                        "Spell Damage": spellDamage.string(2) + "%"
                    ],
                "Misc":
                    [
                        "Attack Animation": attackAnimation,
                        "Attack Range": attackRange.string(0),
                        "Base Attack Time": baseAttackTime.string(1),
                        "Collision Size": collisionSize.string(0),
                        "Magic Resistance": magicResistance.string(0) + "%",
                        "Movement Speed": movementSpeed.string(0),
                        "Projectile Speed": projectileSpeed == 0 ? "Instant" : projectileSpeed.string(0),
                        "Turn Rate": turnRate.string(0),
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
        return base + increment * (level - 1).doubleValue
    }
    
}
