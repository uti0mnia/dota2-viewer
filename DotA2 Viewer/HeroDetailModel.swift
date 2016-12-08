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
    fileprivate var _abilities: [Ability] { get { return _hero.abilities?.array as? [Ability] ?? [Ability]() } }
    fileprivate var _attributes: [Attribute] { get { return _hero.attribute?.allObjects as! [Attribute] } }
    fileprivate var _intelligence: Attribute { get { return _attributes.filter({ $0.name! == "Intelligence"}).first! } }
    fileprivate var _agility: Attribute { get { return _attributes.filter({ $0.name! == "Agility"}).first! } }
    fileprivate var _strength: Attribute { get { return _attributes.filter({ $0.name! == "Strength"}).first! } }
    
    
    /* Public */
    var delegate: HeroDetailModelDelegate?
    var level: Int {
        get { return self._level }
        set (value) { self._level = (value >= 0 && value <= 25) ? value : self._level }
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
    var magicResistance: String { get { return String(format: "%.0f", _hero.miscStats?.magicResistance?.floatValue ?? 0) } }
    var movementSpeed: String { get { return String(format: "%.i", _hero.miscStats?.movementSpeed?.intValue ?? 0) } }
    var projectileSpeed: String { get { return _hero.miscStats?.projectileSpeed ?? "N/A" } }
    var turnRate: String { get { return String(format: "%.1f", _hero.miscStats?.turnRate?.doubleValue ?? 0) } }
    var visionRange: String { get { return _hero.miscStats?.visionRange ?? "N/A" } }
    var bio: String { get { return _hero.summary ?? "N/A" } }
    
    // ** Level dependent
    var intelligence: Double { get { return valueFor(attribute: _intelligence) } }
    var agility: Double { get { return valueFor(attribute: _agility) } }
    var strength: Double { get { return valueFor(attribute: _strength) } }
    var armor: Double { get { return (_hero.baseStats?.armor?.doubleValue ?? 0) + agility / 7 } }
    var damage: (min: Double, max: Double) {
        get {
            let increment = valueFor(attribute: primaryAttribute)
            let min = (_hero.baseStats?.damage?.min?.doubleValue ?? 0) + increment
            let max = (_hero.baseStats?.damage?.max?.doubleValue ?? 0) + increment
            return (min, max)
        }
    }
    var hp: Double { get { return (_hero.baseStats?.hp?.doubleValue ?? 0) + strength * 20 } }
    var hpRegen: Double { get { return (_hero.baseStats?.hpRegen?.doubleValue ?? 0) + strength * 0.03 } }
    var mana: Double { get { return (_hero.baseStats?.mana?.doubleValue ?? 0) + intelligence * 12 } }
    var manaRegen: Double { get { return (_hero.baseStats?.manaRegen?.doubleValue ?? 0) + intelligence * 0.04 } }
    var spellDamage: Double { get { return (_hero.baseStats?.spellDamage?.doubleValue ?? 0) + intelligence * 0.0625 } }
    var attackPerS: Double {
        get { return (100 + agility) * 0.01 / (_hero.miscStats?.attackTime?.doubleValue ?? 0) }
    }
    var abilities: [AbilityModel] { get { return _abilities.map({ AbilityModel(ability: $0) }) } }
    
    // MARK - Functions
    init(hero: Hero) {
        self._hero = hero
        self._level = 1
    }
    
    /* Helper function to find the current value for the ability at the current model level */
    fileprivate func valueFor(attribute: Attribute) -> Double {
        let base = attribute.base?.doubleValue ?? 0
        let increment = attribute.increment?.doubleValue ?? 0
        return base + increment * (_level - 1).doubleValue // the -1 is to offset the data scrapped
    }
    
    
    
}







































