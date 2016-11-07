//
//  HeroStatsVC.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-22.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroStatsVC: DAUIViewController {

    // outlets
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var segmentLevel: UISegmentedControl!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var armorLabel: UILabel!
    @IBOutlet weak var sightLabel: UILabel!
    @IBOutlet weak var attackRangeLabel: UILabel!
    @IBOutlet weak var missleSpeedLabel: UILabel!
    
    // properties
    var stats: [Stat]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadStat(atIndex: 0)
        segmentLevel.addTarget(self, action: #selector(indexChanged(sender:)), for: .valueChanged)
    }
    
    @objc private func indexChanged(sender: UISegmentedControl) {
        loadStat(atIndex: sender.selectedSegmentIndex)
    }
    
    private func loadStat(atIndex index: Int) {
        // make sure we're loading
        guard index < stats.count else { return }
        
        let stat = stats[index]
        
        // set the labels
        hpLabel.text = stat.hp
        manaLabel.text = stat.mana
        damageLabel.text = stat.damage
        armorLabel.text = stat.armor
        sightLabel.text = stat.sight
        attackRangeLabel.text = stat.attackRange
        missleSpeedLabel.text = stat.missleSpeed
        
    }

}










































