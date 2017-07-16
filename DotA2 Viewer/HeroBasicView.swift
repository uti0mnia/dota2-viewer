//
//  HeroBasicView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-09.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SMIconLabel
import SnapKit

class HeroBasicView: UIView {
    
    private static let attributeViewHeight: CGFloat = 70
    
    private(set) var attributeView = HeroAttributeView()
    
    private(set) var hpLabel: SMIconLabel?
    private(set) var manaLabel: SMIconLabel?
    private(set) var damageLabel: SMIconLabel?
    private(set) var armourLabel: SMIconLabel?
    private(set) var spellDamageLabel: SMIconLabel?
    private(set) var attackPerSecondLabel: SMIconLabel?
    
    private(set) var speedLabel = DALabel(style: .text)
    private(set) var turnRateLabel = DALabel(style: .text)
    private(set) var visionRangeLabel = DALabel(style: .text)
    private(set) var attackRangeLabel = DALabel(style: .text)
    private(set) var projectileSpeedLabel = DALabel(style: .text)
    private(set) var attackAnimationLabel = DALabel(style: .text)
    private(set) var baseAttackTimeLabel = DALabel(style: .text)
    private(set) var magicResistanceLabel = DALabel(style: .text)
    private(set) var collisionSizeLabel = DALabel(style: .text)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public static var preferredHeight: CGFloat {
        let labelHeight = Layout.textLabelPreferredHeight
        let padding = Layout.defaultPadding
        
        return HeroBasicView.attributeViewHeight + 12 * labelHeight + 11 * padding
    }
    
    private func commonInit() {
        hpLabel = makeSMIconLabel()
        hpLabel?.icon = #imageLiteral(resourceName: "hp_icon.png") // hp_icon.png
        manaLabel = makeSMIconLabel()
        manaLabel?.icon = #imageLiteral(resourceName: "mana_icon.png") // mana_icon.png
        damageLabel = makeSMIconLabel()
        damageLabel?.icon = #imageLiteral(resourceName: "damage_icon.png") // damage_icon.png
        armourLabel = makeSMIconLabel()
        armourLabel?.icon = #imageLiteral(resourceName: "armour_icon.png") // armour_icon.png
        spellDamageLabel = makeSMIconLabel()
        spellDamageLabel?.icon = #imageLiteral(resourceName: "spell_damage_icon.png") // spell_damage_icon.png
        attackPerSecondLabel = makeSMIconLabel()
        attackPerSecondLabel?.icon = #imageLiteral(resourceName: "time_icon.png") // time_icon.png
        
        // TODO: Does this really look better?
        speedLabel.textAlignment = .center
        turnRateLabel.textAlignment = .center
        visionRangeLabel.textAlignment = .center
        attackRangeLabel.textAlignment = .center
        projectileSpeedLabel.textAlignment = .center
        attackAnimationLabel.textAlignment = .center
        baseAttackTimeLabel.textAlignment = .center
        magicResistanceLabel.textAlignment = .center
        collisionSizeLabel.textAlignment = .center
        
        uti_addSubviews([attributeView, hpLabel, manaLabel, damageLabel, armourLabel, spellDamageLabel, attackPerSecondLabel,
                         speedLabel, turnRateLabel, visionRangeLabel, attackRangeLabel, projectileSpeedLabel,
                         attackAnimationLabel, baseAttackTimeLabel, magicResistanceLabel, collisionSizeLabel])
        
    }
    
    override func layoutSubviews() {
        let leftX: CGFloat = 0
        let rightX: CGFloat = (bounds.width + Layout.defaultPadding) / 2
        let height: CGFloat = Layout.textLabelPreferredHeight
        let halfWidth: CGFloat = (bounds.width - Layout.defaultPadding) / 2
        let fullWidth: CGFloat = bounds.width
        
        var currentY: CGFloat = 0
        
        attributeView.frame = CGRect(x: leftX, y: currentY, width: fullWidth, height: HeroBasicView.attributeViewHeight)
        
        currentY += (HeroBasicView.attributeViewHeight + Layout.defaultPadding)
        
        for (leftLabel, rightLabel) in [(hpLabel, manaLabel), (damageLabel, armourLabel), (spellDamageLabel, attackPerSecondLabel)] {
            leftLabel?.frame = CGRect(x: leftX, y: currentY, width: halfWidth, height: height)
            rightLabel?.frame = CGRect(x: rightX, y: currentY, width: halfWidth, height: height)
            currentY += (height + Layout.defaultPadding)
        }
        
        for label in [speedLabel, turnRateLabel, visionRangeLabel, attackRangeLabel, projectileSpeedLabel, attackAnimationLabel, baseAttackTimeLabel, magicResistanceLabel, collisionSizeLabel] {
            label.frame = CGRect(x: leftX, y: currentY, width: fullWidth, height: height)
            currentY += (height + Layout.defaultPadding)
        }
    }
    
    private func makeSMIconLabel() -> SMIconLabel {
        let label = SMIconLabel()
        label.iconPadding = 5
        label.numberOfLines = 0
        label.iconPosition = (.left, .top)
        return label
    }
    
}
