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
        
        guard hero != nil else {
            return
        }
        
        setup()
    }
    
    
    /* This function sets up the data to be displayed */
    fileprivate func setup() {        
        heroView.imageView.image = hero.getImage()
        heroView.attackTypeLabel.text = (hero.miscStats?.projectileSpeed ?? "" == "Instant") ? "Melee" : "Ranged"
        heroView.rolesLabel.text = (hero.roles!.allObjects as! [ArrayValue]).map({ $0.value ?? "" }).joined(separator: ", ")
        heroView.levelLabel.text = "Level 1"
        let attributes = hero.attribute?.allObjects as! [Attribute]
        let views = [heroView.attribute1View, heroView.attribute2View, heroView.attribute3View]
        for i in 0..<attributes.count { // set up the attributes
            views[i]?.imageView.image = attributes[i].image
            views[i]?.incrementLabel.text = "\(attributes[i].increment!)"
            views[i]?.currentValue.text = String(format: "%.0f", attributes[i].base!.doubleValue + attributes[i].increment!.doubleValue)
        }
        heroView.baseStatsView.armorLabel.text = String(format: "%.0f", hero.baseStats?.armor ?? 0)
        heroView.baseStatsView.hpLabel.text = String(format: "%.0f + %.1f", hero.baseStats?.hp ?? 0, hero.baseStats?.hpRegen ?? 0)
        heroView.baseStatsView.manaLabel.text = String(format: "%.0f + %.1f", hero.baseStats?.mana ?? 0, hero.baseStats?.manaRegen ?? 0)
        heroView.baseStatsView.damageLabel.text = String(format: "%.0f-%.0f", hero.baseStats?.damage?.min ?? 0, hero.baseStats?.damage?.max ?? 0)
        heroView.baseStatsView.attackPerSLabel.text = String(format: "%.0f", hero.baseStats?.attackPerS ?? 0)
        heroView.baseStatsView.spellDmgLabel.text = String(format: "%.0f", hero.baseStats?.spellDamage ?? 0)
        
    }

}
