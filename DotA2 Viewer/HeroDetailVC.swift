//
//  HeroDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-03.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroDetailVC: DADetailVC {
    // MARK - Properties
    fileprivate var hero: Hero!
    fileprivate lazy var heroSV: HeroStackView = {[unowned self] in
        let sv = HeroStackView(abilities: self.model.abilities.count)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    fileprivate var model: HeroDetailModel!
    fileprivate var imageView: UIImageView!
    fileprivate var cachedImageSize: CGRect!
    
    // MARK - Methods
    override func viewDidLoad() {
        // make sure we have an item
        guard let heroObj = object as? Hero else {
            return
        }
        hero = heroObj
        model = HeroDetailModel(hero: hero)
        model.delegate = self
        
        // Configure the VC
        super.viewDidLoad()
        insertAbilities(model.abilities, into: heroSV.abilitiesSV)
        setStats()
    }
    
    /* Adds the main subview */
    override internal func addSubviews() {
        super.addSubviews()
        
        // hero stack view
        scrollView.delegate = self
        scrollView.addSubview(heroSV)
        var constraints = createConstraints(withVisual: "H:|[stackView(==scrollView)]|", withViews: ["stackView": heroSV, "scrollView": scrollView], options: .alignAllCenterX)
        constraints += createConstraints(withVisual: "V:|[stackView]|", withViews: ["stackView": heroSV], options: .alignAllCenterX)
        scrollView.addConstraints(constraints)
    }
    
    /* does the setup from the model to the views */
    override internal func setup() {
        super.setup()
        
        // expandable text SV
        heroSV.bioSV.textLabel.text = model.bio
        heroSV.loreSV.textLabel.text = model.lore
        
        // main view
        heroSV.mainSV.attackTypeLabel.text = (model.projectileSpeed == "Instant") ? "Melee" : "Ranged"
        heroSV.mainSV.imageView.image = model.image
        heroSV.mainSV.rolesLabel.text = model.roles.joined(separator: ", ")
        
    }
    
    fileprivate func setStats() {
        DispatchQueue.main.async {
            let subSV = HeroStatsSubStackView()
            
            // top
            subSV.levelLabel.text = "Level 1"
            subSV.slider.delegate = self
            
            // middle
            subSV.strengthSV.imageView.image = #imageLiteral(resourceName: "strength_icon.png") // strength_icon.png
            subSV.strengthSV.label.text = "\(self.model.strength.format(0)) (+\(self.model.strengthIncrement.format(1)))"
            subSV.agilitySV.imageView.image = #imageLiteral(resourceName: "agility_icon.png") // agility_icon.png
            subSV.agilitySV.label.text = "\(self.model.agility.format(0)) (+\(self.model.agilityIncrement.format(1)))"
            subSV.intelligenceSV.imageView.image = #imageLiteral(resourceName: "intelligence_icon.png") // intelligence_icon.png
            subSV.intelligenceSV.label.text = "\(self.model.intelligence.format(0)) (+\(self.model.intelligenceIncrement.format(1)))"
            subSV.hpLabel.text = "\(self.model.hp.format(0)) + \(self.model.hpRegen.format(1))"
            subSV.manaLabel.text = "\(self.model.mana.format(0)) + \(self.model.manaRegen.format(1))"
            switch self.model.primaryAttribute.name ?? "" {
            case "Strength":
                subSV.strengthSV.backgroundColor = UIColor.flatMaroonColorDark()
            case "Agility":
                subSV.agilitySV.backgroundColor = UIColor.flatForestGreenColorDark()
            default:
                subSV.intelligenceSV.backgroundColor = UIColor.flatSkyBlueColorDark()
            }
            
            // bottom
            subSV.damageLabel.text = "Dmg: \(self.model.damage.min.format(0)) - \(self.model.damage.max.format(0))"
            subSV.attackPerSLabel.text = "Attack/s: \(self.model.attackPerS.format(2))"
            subSV.armorLabel.text = "Armor: \(self.model.armor.format(2))"
            subSV.spellDmgLabel.text = "Spell Dmg: \(self.model.spellDamage.format(2))%"
            subSV.attackAnimationLabel.text = "Attack Animation: \(self.model.attackAnimation)"
            subSV.attackRangeLabel.text = "Attack Range: \(self.model.attackRange)"
            subSV.moveSpeedLabel.text = "Movement Speed: \(self.model.movementSpeed)"
            subSV.projectileSpeedLabel.text = "Projectile Speed: \(self.model.projectileSpeed)"
            subSV.collisionSizeLabel.text = "Collision Size: \(self.model.collisionSize)"
            subSV.magicResistanceLabel.text = "Magic Resistance: \(self.model.magicResistance)%"
            subSV.turnRateLabel.text = "Turn Rate: \(self.model.turnRate)"
            subSV.visionLabel.text = "Vision: \(self.model.visionRange)"
            
            // set subView
            self.heroSV.statsSV.setSubview(subSV)
        }
    }
    
    /* This fuctions reloads the labels in the cells that are level dependent */
    fileprivate func reloadLevel() {
        if let subView = heroSV.statsSV.subView as? HeroStatsSubStackView {
            // top
            subView.levelLabel.text = "Level \(model.level)"
            
            // middle
            subView.strengthSV.label.text = "\(self.model.strength.format(0)) (+\(self.model.strengthIncrement.format(1)))"
            subView.agilitySV.label.text = "\(self.model.agility.format(0)) (+\(self.model.agilityIncrement.format(1)))"
            subView.intelligenceSV.label.text = "\(self.model.intelligence.format(0)) (+\(self.model.intelligenceIncrement.format(1)))"
            subView.hpLabel.text = "\(self.model.hp.format(0)) + \(self.model.hpRegen.format(1))"
            subView.manaLabel.text = "\(self.model.mana.format(0)) + \(self.model.manaRegen.format(1))"
            
            // bottom
            subView.damageLabel.text = "Dmg: \(self.model.damage.min.format(0)) - \(self.model.damage.max.format(0))"
            subView.attackPerSLabel.text = "Attack/s: \(self.model.attackPerS.format(2))"
            subView.armorLabel.text = "Armor: \(self.model.armor.format(2))"
            subView.spellDmgLabel.text = "Spell Dmg: \(self.model.spellDamage.format(2))%"
        }
    }
    

}

extension HeroDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}

extension HeroDetailVC: DASliderDelegate {
    func slider(_ slider: DASlider, didUpdateTo value: Int) {
        model.level = value
    }
}

extension HeroDetailVC: HeroDetailModelDelegate {
    func modelDidUpdate() {
        // reload data
        reloadLevel()
    }
}
































