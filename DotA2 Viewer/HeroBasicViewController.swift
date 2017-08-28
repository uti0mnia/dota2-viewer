//
//  HeroBasicViewController.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-14.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import CoreData
import SnapKit
import SwiftMessages


/*
 * This view controller is meant to handle basic details of a hero like attributes 
 * and stats. Most of the stats and the attributes can be changed with the slider.
 */
class HeroBasicViewController: UIViewController, HeroDelegate, HeroAttributeViewDelegate, HeroBasicViewDelegate {
    
    private let heroBasicView = HeroBasicView()
    private let scrollView = UIScrollView()
    
    public var hero: Hero? {
        didSet {
            guard let hero = hero else {
                return
            }
            
            hero.delegate = self
            
            heroBasicView.attributeView.resetSlider(animated: false)
            
            heroBasicView.speedLabel.text = "Movement Speed: \(hero.movementSpeed.u0_string(0))"
            heroBasicView.turnRateLabel.text = "Turn Rate: \(hero.turnRate)"
            heroBasicView.visionRangeLabel.text = "Vision Range: \(hero.visionRange)"
            heroBasicView.attackRangeLabel.text = "Attack Range: \(hero.attackRange.u0_string(0))"
            
            let projectileSpeed = hero.projectileSpeed == 0 ? "Instant" : "\(hero.projectileSpeed.u0_string(0))"
            heroBasicView.projectileSpeedLabel.text = "Projectile Speed: " + projectileSpeed
            
            heroBasicView.attackAnimationLabel.text = "Attack Animation: \(hero.attackAnimation)"
            heroBasicView.baseAttackTimeLabel.text = "Base Attack Time: \(hero.baseAttackTime)"
            heroBasicView.magicResistanceLabel.text = "Magic Resistance: \(hero.magicResistance)"
            heroBasicView.collisionSizeLabel.text = "Collision Size: \(hero.collisionSize.u0_string(0))"
            
            setHeroLevelDependentViews()
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalTo(view)
        }
        
        heroBasicView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: HeroBasicView.preferredHeight)
        scrollView.addSubview(heroBasicView)
        scrollView.contentSize = CGSize(width: heroBasicView.bounds.width, height: heroBasicView.bounds.height)
        
        heroBasicView.delegate = self
        heroBasicView.attributeView.delegate = self
    }

    private func setHeroLevelDependentViews() {
        guard let hero = hero else {
            return
        }
        
        heroBasicView.attributeView.levelLabel.text = "Level \(hero.level)"
        
        heroBasicView.attributeView.setPrimaryAttribute(hero.primaryAttribute.heroAttribute)
        heroBasicView.attributeView.agilityLabel.text = "\(hero.agility.u0_string(1)) (+\(hero.agilityGain.u0_string(1)))"
        heroBasicView.attributeView.intelligenceLabel.text = "\(hero.intelligence.u0_string(1)) (+\(hero.intelligenceGain.u0_string(1)))"
        heroBasicView.attributeView.strengthLabel.text = "\(hero.strength.u0_string(1)) (+\(hero.strengthGain.u0_string(1)))"

        
        heroBasicView.hpView?.label.text = "\(hero.hp.u0_string(0)) + \(hero.hpRegen.u0_string(2))"
        heroBasicView.manaView?.label.text = "\(hero.mana.u0_string(0)) + \(hero.manaRegen.u0_string(2))"
        heroBasicView.damageView?.label.text = "\(hero.damage.min.u0_string(0))-\(hero.damage.min.u0_string(0))"
        heroBasicView.armourView?.label.text = "\(hero.armour.u0_string(2))"
        heroBasicView.spellDamageView?.label.text = "\(hero.spellDamage.u0_string(2))"
        heroBasicView.attackPerSecondView?.label.text = "\(hero.attackPerSecond.u0_string(2))"
    }
    
    
    // MARK: - HeroDelegate
    
    func heroDidUpdateLevel() {
        setHeroLevelDependentViews()
    }
    
    // MARK: - HeroAttributeViewDelegate
    
    func heroAttributeView(_ heroAttributeView: HeroAttributeView, sliderDidChangeValue newValue: Int) {
        hero?.level = newValue
    }
    
     // MARK: - HeroBasicViewDelegate
    func heroBasicView(_ heroBasicView: HeroBasicView, didTapOnLabelWithType type: HeroBasicViewLabelType) {
        ToastManager.shared.displayToastMessage(type.description, on: self)
    }
    
}
