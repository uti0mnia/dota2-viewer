//
//  HeroBasicView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-09.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class HeroBasicView: UIView {
    
    private static let attributeViewHeight: CGFloat = 140
    
    private(set) var attributeView = HeroAttributeView()
    
    private(set) var hpView: DAIconLabelView?
    private(set) var manaView: DAIconLabelView?
    private(set) var damageView: DAIconLabelView?
    private(set) var armourView: DAIconLabelView?
    private(set) var spellDamageView: DAIconLabelView?
    private(set) var attackPerSecondView: DAIconLabelView?
    
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
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    public static var preferredHeight: CGFloat {
        let labelHeight = Layout.textLabelPreferredHeight
        let padding = Layout.defaultPadding
        
        return HeroBasicView.attributeViewHeight + 12 * labelHeight + 14 * padding // padding for top and bottom
    }
    
    private func commonInit() {
        hpView = makeDAIconLabel()
        hpView?.icon = #imageLiteral(resourceName: "hp_icon.png") // hp_icon.png
        manaView = makeDAIconLabel()
        manaView?.icon = #imageLiteral(resourceName: "mana_icon.png") // mana_icon.png
        damageView = makeDAIconLabel()
        damageView?.icon = #imageLiteral(resourceName: "damage_icon.png") // damage_icon.png
        armourView = makeDAIconLabel()
        armourView?.icon = #imageLiteral(resourceName: "armour_icon.png") // armour_icon.png
        spellDamageView = makeDAIconLabel()
        spellDamageView?.icon = #imageLiteral(resourceName: "spell_damage_icon.png") // spell_damage_icon.png
        attackPerSecondView = makeDAIconLabel()
        attackPerSecondView?.icon = #imageLiteral(resourceName: "time_icon.png") // time_icon.png
        
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
        
        u0_addSubviews([attributeView, hpView, manaView, damageView, armourView, spellDamageView, attackPerSecondView,
                         speedLabel, turnRateLabel, visionRangeLabel, attackRangeLabel, projectileSpeedLabel,
                         attackAnimationLabel, baseAttackTimeLabel, magicResistanceLabel, collisionSizeLabel])
        
    }
    
    override func layoutSubviews() {
        
        let height: CGFloat = Layout.textLabelPreferredHeight
        let halfWidth: CGFloat = (bounds.width - Layout.defaultPadding) / 2
        let fullWidth: CGFloat = bounds.width
        
        var currentY: CGFloat = Layout.defaultPadding
        
        attributeView.frame = CGRect(x: 0, y: currentY, width: fullWidth, height: HeroBasicView.attributeViewHeight)
        
        currentY += (HeroBasicView.attributeViewHeight + Layout.defaultPadding)
        
        let labelSizeToFit = CGSize(width: halfWidth, height: height)
        for (leftView, rightView) in [(hpView, manaView), (damageView, armourView), (spellDamageView, attackPerSecondView)] {
            guard let leftView = leftView, let rightView = rightView else {
                assertionFailure("HeroBasicView improper view intialization")
                continue
            }
            
            let leftViewSize = leftView.sizeThatFits(labelSizeToFit)
            let leftX = bounds.width / 4 - leftViewSize.width / 2
            leftView.frame = CGRect(x: leftX, y: currentY, width: halfWidth, height: height)
            
            let rightViewSize = rightView.sizeThatFits(labelSizeToFit)
            let rightX = 3 * bounds.width / 4 - rightViewSize.width / 2
            rightView.frame = CGRect(x: rightX, y: currentY, width: halfWidth, height: height)
            
            currentY += (height + Layout.defaultPadding)
        }
        
        for label in [speedLabel, turnRateLabel, visionRangeLabel, attackRangeLabel, projectileSpeedLabel, attackAnimationLabel, baseAttackTimeLabel, magicResistanceLabel, collisionSizeLabel] {
            label.frame = CGRect(x: 0, y: currentY, width: fullWidth, height: height)
            currentY += (height + Layout.defaultPadding)
        }
    }
    
    private func makeDAIconLabel() -> DAIconLabelView {
        let view = DAIconLabelView()
        view.iconPadding = 8
        view.iconSize = Layout.textAttachmentBounds.size
        return view
    }
    
}
