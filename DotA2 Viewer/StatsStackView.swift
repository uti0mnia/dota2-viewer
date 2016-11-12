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
                
                self.addArrangedSubviews(views: [left, right])
                
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
            manaStack = DoubleStackView(left: DAMainLabel(), right: DAMainLabel())
            spellStack = DoubleStackView(left: DAMainLabel(), right: DAMainLabel())
            damageStack = DoubleStackView(left: DAMainLabel(), right: DAMainLabel())
            attackStack = DoubleStackView(left: DAMainLabel(), right: DAMainLabel())
            speedStack = DoubleStackView(left: DAMainLabel(), right: DAMainLabel())
            visionLabel = DAMainLabel()
            
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
    var damage: (Int, Int) { get {
        guard let base = stats.damage else {
            print("Problem getting damage")
            return (0,0)
        }
        
        // return a new damage range with increased stats
        let min = base.min.intValue + Int(currentStrength)
        let max = base.max.intValue + Int(currentStrength)
        return (min, max)
        }
    }
    var armor: Double { get {
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
        levelLabel = DAMainLabel(style: .large)
        slider = DASlider()
        slider.delegate = self
        attributesSV = AttributesStackView(attributeSet: set)
        microStatsView = MicroStatsStackView(stats: stats)
        visionLabel = DAMainLabel()
        
        self.addArrangedSubviews(views: [levelLabel, slider, attributesSV, microStatsView, visionLabel])
        
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
        microStatsView.spellStack.left.text = String(format: "Spell Damage: %@%.1f", "%", spellDamage)
        microStatsView.spellStack.right.text = String(format: "Magic Resistant: %@%i", "%", stats.magicResistance.intValue)
        microStatsView.damageStack.left.text = "Damage: \(damage.0)-\(damage.1)"
        microStatsView.damageStack.right.text = String(format: "Armor: %.1f", armor)
        microStatsView.attackStack.left.text = "Attack Animation: \(stats.attackAnimation!)s"
        microStatsView.attackStack.right.text = "Attack Range: \(stats.attackRange.intValue)"
        microStatsView.speedStack.left.text = "Speed: \(stats.speed.intValue)"
        microStatsView.speedStack.right.text = "Projectile Speed: \(stats.projectileSpeed!)"
        visionLabel.text = "Vision \(stats.vision!)"
        
    }
    
}

extension StatsStackView: DASliderDelegate {
    func slider(_ slider: DASlider, didUpdateTo value: Int) {
        setLevel(level: value)
    }
}

















































