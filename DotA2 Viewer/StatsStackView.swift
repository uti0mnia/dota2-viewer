//
//  StatsStackView.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-26.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class StatsStackView: UIStackView {
    
    class MicroStatsStackView: UIStackView {
        
        class DoubleStackView: UIStackView {
            var left: UILabel!
            var right: UILabel!
            
            init(left: UILabel, right: UILabel) {
                self.left = left
                self.right = right
                
                super.init(frame: CGRect())
                
                // StackView properties
                self.axis = .horizontal
                self.alignment = .fill
                self.distribution = .fillEqually
                self.spacing = 4
            }
            
            required init(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }
        
        // properties
        var hpStack: DoubleStackView! // for hp and hpRegen
        var manaStack: DoubleStackView! // for mana and manaRegen
        var spellStack: DoubleStackView! // for spellDamage and MagicResistance
        var damageStack: DoubleStackView! // for damage and armor
        var attackStack: DoubleStackView! // for attackAnimation and attackRange
        var speedStack: DoubleStackView! // for speed and projectileSpeed
        var visionLabel: DAMainLabel! // for vision
        
        
        init(stats: Stats) {
            
            // set views
            hpStack = DoubleStackView(left: DAMainLabel(), right: DAMainLabel())
            hpStack.left.text = String(format: "%.0f", stats.hp)
            hpStack.right.text = String(format: "%.0f", stats.hpRegen)
            
            manaStack = DoubleStackView(left: DAMainLabel(), right: DAMainLabel())
            manaStack.left.text = String(format: "%.0f", stats.mana)
            manaStack.right.text = String(format: "%.0f", stats.manaRegen)
            
            spellStack = DoubleStackView(left: DAMainLabel(), right: DAMainLabel())
            spellStack.left.text = String(format: "%.0f", stats.spellDamage)
            spellStack.right.text = String(format: "%.0f", stats.magicResistance)
            
            damageStack = DoubleStackView(left: DAMainLabel(), right: DAMainLabel())
            damageStack.left.text = stats.damage
            damageStack.right.text = String(format: "%.0f", stats.armor)
            
            attackStack = DoubleStackView(left: DAMainLabel(), right: DAMainLabel())
            attackStack.left.text = stats.attackAnimation
            attackStack.right.text = String(format: "%.0f", stats.attackRange)
            
            speedStack = DoubleStackView(left: DAMainLabel(), right: DAMainLabel())
            speedStack.left.text = String(format: "%.0f", stats.speed)
            speedStack.right.text = stats.projectileSpeed
            
            visionLabel = DAMainLabel()
            visionLabel.text = stats.vision
            
            // initialize self
            super.init(frame: CGRect())
            
            // add the subviews
            self.addArrangedSubviews(views: [hpStack, manaStack, spellStack, damageStack, attackStack, speedStack, visionLabel])
            
            
            // set self properties
            self.axis = .vertical
            self.alignment = .fill
            self.distribution = .fillEqually
            self.spacing = 8
        }
        
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }

    // var
    private var level: Int!
    private var attributeSet: AttributeSet!
    private var stats: Stats!
    private var levelLabel: DAMainLabel!
    private var slider: DASlider!
    private var attributesSV: AttributesStackView!
    private var microStatsView: MicroStatsStackView!
    private var visionLabel: DAMainLabel!
    
    // getters for calculations
    var currentStrength: Double { get {
        let base = attributeSet.strength.base.doubleValue
        let increment = attributeSet.strength.increment.doubleValue * (level - 1).nsDecimalValue.doubleValue
        return base + increment
        }
    }
    var currentAgility: Double { get {
        let base = attributeSet.agility.base.doubleValue
        let increment = attributeSet.agility.increment.doubleValue * (level - 1).nsDecimalValue.doubleValue
        return base + increment
        }
    }
    var currentInteligence: Double { get {
        let base = attributeSet.intelligence.base.doubleValue
        let increment = attributeSet.intelligence.increment.doubleValue * (level - 1).nsDecimalValue.doubleValue
        return base + increment
        }
    }
    var hp: Int { get {
        let base = stats.hp.doubleValue
        return Int(base + currentStrength * kHPGain.doubleValue)
        }
    }
    var hpRegen: Double { get {
        let base = stats.hpRegen.doubleValue
        return base + currentStrength * kHPRegenGain.doubleValue
        }
    }
    var mana: Int { get {
        let base = stats.mana.doubleValue
        return Int(base + currentInteligence * kManaGain.doubleValue)
        }
    }
    var manaRegen: Double { get {
        let base  = stats.manaRegen.doubleValue
        return base + currentInteligence * kManaRegenGain.doubleValue
        }
    }
    var spellDamage: Double { get {
        let base = stats.spellDamage.doubleValue
        return base + currentInteligence * kSpellDamageGain.doubleValue
        }
    }
    var damage: DamageRange { get {
        let data = stats.damage
        // make sure we can get a damage range out of the data
        guard let dmgRng = DamageRange.from(data: data!) else {
            print("Problem with damage range")
            return DamageRange(min: 0, max: 0)
        }
        
        // return a new damage range with increased stats
        let min = dmgRng.min + Int(currentStrength)
        let max = dmgRng.max + Int(currentStrength)
        return DamageRange(min: min, max: max)
        }
    }
    var armour: Double { get {
        let base = stats.armor.doubleValue
        return base + currentAgility * kArmourGain.doubleValue
        }
    }
    
    init(frame: CGRect, attributeSet set: AttributeSet, stats: Stats) {
        // properties
        self.attributeSet = set
        self.stats = stats
        self.level = 1
        
        
        // init super
        super.init(frame: frame)
        
        // configure the views
        levelLabel = DAMainLabel()
        slider = DASlider()
        slider.delegate = self
        attributesSV = AttributesStackView(attributeSet: set)
        microStatsView = MicroStatsStackView(stats: stats)
        visionLabel = DAMainLabel()
        
        self.addArrangedSubviews(views: [levelLabel, slider, attributesSV, microStatsView])
        
        // configure self
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 8
        
        // set the stats for level 1
        setLevel(level: self.level)
        
    }
    
    convenience init(attributeSet set: AttributeSet, stats: Stats) {
        self.init(frame: CGRect(), attributeSet: set, stats: stats)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLevel(level: Int) {
        guard level >= 1 && level <= 25 else {
            return
        }
        
        // set the property
        self.level = level
        
        // set the level label
        levelLabel.text = "Level \(level)"
        // set the attributes
        attributesSV.setLevel(level: level)
        
        // setting the attributes
        microStatsView.hpStack.left.text = "HP: \(hp)"
        microStatsView.hpStack.right.text = String(format: "HP Regen: %.2f", hpRegen)
        microStatsView.manaStack.left.text = "Mana: \(mana)"
        microStatsView.manaStack.right.text = String(format: "Mana Regen: %.2f", manaRegen)
        microStatsView.spellStack.left.text = String(format: "Spell Damage: %@%.2f", ["%", spellDamage])
        microStatsView.spellStack.right.text = String(format: "Magic Resistant: %@%.2f", ["%", stats.magicResistance])
        microStatsView.damageStack.left.text = "Damage: \(damage.min)-\(damage.max)"
        microStatsView.damageStack.right.text = String(format: "Armour: %.2f", armour)
        microStatsView.attackStack.left.text = "Attack Animation: \(stats.attackAnimation)s"
        microStatsView.attackStack.right.text = "Attack Range: \(stats.attackRange.intValue)"
        microStatsView.speedStack.left.text = "Speed: \(stats.speed.intValue)"
        microStatsView.speedStack.right.text = "Projectile Speed: \(stats.projectileSpeed)"
        visionLabel.text = "Vision \(stats.vision) (day/night)"
        
    }
    
}

extension StatsStackView: DASliderDelegate {
    func slider(_ slider: DASlider, didUpdateTo value: Int) {
        setLevel(level: value)
    }
}

















































