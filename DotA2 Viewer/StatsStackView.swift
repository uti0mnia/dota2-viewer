//
//  StatsStackView.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-26.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class StatsStackView: UIStackView {

    // outlets
    var slider: DASlider!
    var hpLabel: UILabel!
    var manaLabel: UILabel!
    var damageLabel: UILabel!
    var armorLabel: UILabel!
    var sightLabel: UILabel!
    var attackRangeLabel: UILabel!
    var missleSpeedLabel: UILabel!
    
    // properties
    var stats: Stats!
    
    func setStack() {
        // configure the views
        slider = DASlider()
        
        hpLabel = UILabel()
        manaLabel = UILabel()
        damageLabel = UILabel()
        armorLabel = UILabel()
        sightLabel = UILabel()
        attackRangeLabel = UILabel()
        missleSpeedLabel = UILabel()
        
        for i in [slider, hpLabel, manaLabel, damageLabel, armorLabel, sightLabel, attackRangeLabel, missleSpeedLabel] as [UIView] {
            self.addArrangedSubview(i)
        }
        
        // configure self
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 8
        
        // load the data
        loadStat(atIndex: 0)
        segmentLevel.addTarget(self, action: #selector(indexChanged(sender:)), for: .valueChanged)
    }
    
    @objc private func indexChanged(sender: UISegmentedControl) {
        loadStat(atIndex: sender.selectedSegmentIndex)
    }
    
    fileprivate func loadStat(atIndex index: Int) {
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
