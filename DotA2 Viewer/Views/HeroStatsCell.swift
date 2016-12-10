//
//  HeroStatsCell.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroStatsCell: ExpandableCell {
    // MARK - Outlets
    @IBOutlet weak var mainSV: UIStackView!
    @IBOutlet weak var stackView: UIStackView!
    
    /* Base Stats */
    @IBOutlet weak var baseStatsView: UIStackView!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var attackPerSLabel: UILabel!
    @IBOutlet weak var armorLabel: UILabel!
    @IBOutlet weak var spellDmgLabel: UILabel!
    
    /* Misc Stats */
    @IBOutlet weak var miscStatsView: UIStackView!
    @IBOutlet weak var attackAnimationLabel: UILabel!
    @IBOutlet weak var attackRangeLabel: UILabel!
    @IBOutlet weak var moveSpeedLabel: UILabel!
    @IBOutlet weak var projectileSpeedLabel: UILabel!
    @IBOutlet weak var collisionSizeLabel: UILabel!
    @IBOutlet weak var magicResistanceLabel: UILabel!
    @IBOutlet weak var turnRateLabel: UILabel!
    @IBOutlet weak var visionLabel: UILabel!
    
    override func toggle() {
        super.toggle()
        setSpacing(for: mainSV)
        baseStatsView.isHidden = !isExpanded
        miscStatsView.isHidden = !isExpanded
    }
    
    
}





































