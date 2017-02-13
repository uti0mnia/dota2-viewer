//
//  Hero.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-12.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

class Hero {
    // hero data structures
    private enum AttributeType: String { case int = "Intelligence", agi = "Agility", strength = "Strength" }
    private struct Attribute {
        var type: AttributeType
        var base: Int
        var isPrimary: Bool
        var increment: Double
    }
    private struct Talent {
        var level: Int
        var left: String
        var right: String
        var notes: [Note]
    }
    private struct BaseStat {
        var spellDamage: Double // is a percentage
        var hpRegen: Double
        var armor: Double
        var hp: Double
        var damage: (Double, Double)
        var mana: Double
        var manaRegen: Double
        var attackPerSecond: Double
    }
    private struct MiscStat {
        /* Make everything comparable in case we want sorting in the future */
        var projectileSpeed: Int
        var attackAnimation: (Double, Double)
        var turnRate: Double
        var baseAttackTime: Double
        var collisionSize: Double
        var attackRange: Int
        var moveSpeed: Int
        var visionRange: (Int, Int)
        var magicResistance: Int // is a percentage
        
    }
    
    // properties
    private(set) var name: String
	private(set) var description: String
    private(set) var roles: [String]
    private(set) var talents: [Talent]
    private(set) var lore: String
    private(set) var attributes: [Attribute]
    private(set) var baseStats: BaseStat
    private(set) var miscStats: MiscStat
    private(set) var abilities: [Ability]
}
