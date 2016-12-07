//
//  HeroDetailModel.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-07.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation
import CoreData

protocol HeroDetailModelDelegate {
    func modelDidUpdate()
}

class HeroDetailModel {
    // MARK - Properties
    /* Private */
    fileprivate var _hero: Hero!
    fileprivate var _level: Int! { didSet { delegate?.modelDidUpdate() } }
    fileprivate var _attributes: [Attribute] { get { return _hero.attribute?.allObjects as! [Attribute] } }
    fileprivate var _intelligence: Attribute { get { return _attributes.filter({ $0.name! == "Intelligence"}).first! } }
    fileprivate var _agility: Attribute { get { return _attributes.filter({ $0.name! == "Agility"}).first! } }
    fileprivate var _strength: Attribute { get { return _attributes.filter({ $0.name! == "Strength"}).first! } }
    
    
    /* Public */
    var delegate: HeroDetailModelDelegate?
    var level: Int {
        get { return self._level }
        set { self._level = (level >= 0 && level <= 25) ? level : self._level }
    }
    
    // ** Not level dependent
    var primaryAttribute: Attribute { get { return _attributes.filter({ $0.isPrimary! == 1 }).first! } }
    var intelligenceIncrement: Double { get { return _intelligence.increment?.doubleValue ?? 0 } }
    var agilityIncrement: Double { get { return _agility.increment?.doubleValue ?? 0 } }
    var strengthIncrement: Double { get { return _strength.increment?.doubleValue ?? 0 } }
    var attackAnimation: String { get { return _hero.miscStats?.attackAnimation ?? "N/A" } }
    var attackRange: String { get { return String(format: "%i", _hero.miscStats?.attackRange?.intValue ?? 0) } }
    var attackTime: String { get { return String(format: "%i", _hero.miscStats?.attackTime?.intValue ?? 0) } }
    var collisionSize: String { get { return String(format: "%i", _hero.miscStats?.collisionSize?.intValue ?? 0) } }
    var magicResistance: String { get { return String(format: "%.2f", _hero.miscStats?.magicResistance?.floatValue ?? 0) } }
    var movementSpeed: String { get { return String(format: "%.i", _hero.miscStats?.movementSpeed?.intValue ?? 0) } }
    var projectileSpeed: String { get { return _hero.miscStats?.projectileSpeed ?? "N/A" } }
    var turnRate: String { get { return String(format: "%.i", _hero.miscStats?.turnRate?.intValue ?? 0) } }
    var visionRange: String { get { return _hero.miscStats?.visionRange ?? "N/A" } }
    
    // ** Level dependent
    var intelligence: Int { get { return valueFor(attribute: _intelligence) } }
    var agility: Int { get { return valueFor(attribute: _agility) } }
    var strength: Int { get { return valueFor(attribute: _strength) } }
    var armor: Double { get { return _hero.baseStats?.armor?.doubleValue ?? 0 + agility.doubleValue / 7 } }
    var damage: (min: Int, max: Int) {
        get {
            let increment = valueFor(attribute: primaryAttribute)
            let min = _hero.baseStats?.damage?.min?.intValue ?? 0 + increment
            let max = _hero.baseStats?.damage?.max?.intValue ?? 0 + increment
            return (min, max)
        }
    }
    var hp: Int { get { return _hero.baseStats?.hp?.intValue ?? 0 + strength * 20 } }
    var hpRegen: Double { get { return _hero.baseStats?.hpRegen?.doubleValue ?? 0 + strength.doubleValue * 0.3 } }
    var mana: Int { get { return _hero.baseStats?.mana?.intValue ?? 0 + intelligence * 12 } }
    var manaRegen: Double { get { return _hero.baseStats?.manaRegen?.doubleValue ?? 0 + intelligence.doubleValue * 0.04 } }
    var spellDamage: Double { get { return _hero.baseStats?.spellDamage?.doubleValue ?? 0 + intelligence.doubleValue * 0.0625 } }
    var attackPerS: Double {
        get { return (100 + agility.doubleValue) * 0.01 / (_hero.baseStats?.attackPerS?.doubleValue ?? 1.0) }
    }
    
    // MARK - Functions
    init(hero: Hero) {
        self._hero = hero
        self._level = 1
    }
    
    /* Helper function to find the current value for the ability at the current model level */
    fileprivate func valueFor(attribute: Attribute) -> Int {
        let base = attribute.base?.doubleValue ?? 0
        let increment = attribute.increment?.doubleValue ?? 0
        return Int(base + increment * (_level - 1).doubleValue) // the -1 is to offset the data scrapped
    }
    
    
    
}







































