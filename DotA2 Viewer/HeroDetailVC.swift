//
//  HeroDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-03.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroDetailVC: DAUIViewController {
    // MARK - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var heroView: HeroView!
    
    // MARK - Properties
    var hero: Hero!
    
    // MARK - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard hero != nil else { return }
        
        // set title
        let title = DAMainLabel(style: .xlarge)
        title.text = hero.name!
        title.sizeToFit()
        self.navigationItem.titleView = title
        
        // set the view up
        setup()
    }
    
    
    /* This function sets up the data to be displayed */
    fileprivate func setup() {
        // ** Immediate info
        heroView.imageView.image = hero.getImage()
        heroView.attackTypeLabel.text = (hero.miscStats?.projectileSpeed ?? "" == "Instant") ? "Melee" : "Ranged"
        heroView.rolesLabel.text = (hero.roles!.allObjects as! [ArrayValue]).map({ $0.value ?? "" }).joined(separator: ", ")
        heroView.levelLabel.text = "Level 1"
        heroView.slider.delegate = self
        
        // ** Attributes
        let attributes = hero.attribute?.allObjects as! [Attribute]
        let views = [heroView.attribute1View, heroView.attribute2View, heroView.attribute3View]
        for i in 0..<attributes.count { // set up the attributes
            views[i]?.imageView.image = attributes[i].image
            views[i]?.incrementLabel.text = "\(attributes[i].increment!)"
            views[i]?.currentValue.text = String(format: "%.0f", attributes[i].base!.doubleValue + attributes[i].increment!.doubleValue)
        }
        
        // ** Base Stats
        heroView.baseStatsView.armorLabel.text = String(format: "%.1f", hero.baseStats?.armor?.floatValue ?? 0)
        heroView.baseStatsView.hpLabel.text = String(format: "%.0f + %.1f", hero.baseStats?.hp?.floatValue ?? 0, hero.baseStats?.hpRegen?.floatValue ?? 0)
        heroView.baseStatsView.manaLabel.text = String(format: "%.0f + %.1f", hero.baseStats?.mana?.floatValue ?? 0, hero.baseStats?.manaRegen?.floatValue ?? 0)
        heroView.baseStatsView.damageLabel.text = String(format: "%.0f-%.0f", hero.baseStats?.damage?.min?.floatValue ?? 0, hero.baseStats?.damage?.max?.floatValue ?? 0)
        heroView.baseStatsView.attackPerSLabel.text = String(format: "%.2f", hero.baseStats?.attackPerS?.floatValue ?? 0)
        heroView.baseStatsView.spellDmgLabel.text = String(format: "%.0f", hero.baseStats?.spellDamage?.floatValue ?? 0)
        
        // ** Misc Stats
        heroView.miscStatsView.attackAnimationLabel.text = hero.miscStats?.attackAnimation ?? "N/A"
        heroView.miscStatsView.attackRangeLabel.text = String(format: "%i", hero.miscStats?.attackRange?.intValue ?? 0)
        heroView.miscStatsView.collisionSizeLabel.text = String(format: "%.i", hero.miscStats?.collisionSize?.intValue ?? 0)
        heroView.miscStatsView.magicResistanceLabel.text = String(format: "%.2f", hero.miscStats?.magicResistance?.floatValue ?? 0)
        heroView.miscStatsView.moveSpeedLabel.text = String(format: "%i", hero.miscStats?.movementSpeed?.intValue ?? 0)
        heroView.miscStatsView.projectileSpeedLabel.text = hero.miscStats?.projectileSpeed ?? "N/A"
        heroView.miscStatsView.turnRateLabel.text = String(format: "%i", hero.miscStats?.turnRate?.intValue ?? 0)
        heroView.miscStatsView.visionLabel.text = hero.miscStats?.visionRange ?? "N/A"
        
    }

}

extension HeroDetailVC: DASliderDelegate {
    func slider(_ slider: DASlider, didUpdateTo value: Int) {
        heroView.levelLabel.text = "Level \(value)"
    }
}
































