//
//  HeroBasicView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-09.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

public enum HeroBasicViewLabelType: Int {
    case hp = 0, mana, damage, armour, spellDamage, attackPerSecond
    
    public var description: String {
        switch self {
        case .hp:
            return "Health + Health Regen"
        case .mana:
            return "Mana + Mana Regen"
        case .damage:
            return "Damage"
        case .armour:
            return "Armour"
        case .spellDamage:
            return "Spell Damage"
        case .attackPerSecond:
            return "Attacks per second"
        }
    }
}

class HeroBasicView: UIView {
    
    private static let attributeViewHeight: CGFloat = 140
    
    public weak var delegate: HeroBasicViewDelegate?
    
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
        
        hpView = createDAIconLabelView()
        hpView?.tag = 0
        hpView?.icon = #imageLiteral(resourceName: "hp_icon.png") // hp_icon.png
        
        manaView = createDAIconLabelView()
        manaView?.tag = 1
        manaView?.icon = #imageLiteral(resourceName: "mana_icon.png") // mana_icon.png
        
        damageView = createDAIconLabelView()
        damageView?.tag = 2
        damageView?.icon = #imageLiteral(resourceName: "damage_icon.png") // damage_icon.png
        
        armourView = createDAIconLabelView()
        armourView?.tag = 3
        armourView?.icon = #imageLiteral(resourceName: "armour_icon.png") // armour_icon.png
        
        spellDamageView = createDAIconLabelView()
        spellDamageView?.tag = 4
        spellDamageView?.icon = #imageLiteral(resourceName: "spellDamage_icon.png") // spellDamage_icon.png
        
        attackPerSecondView = createDAIconLabelView()
        attackPerSecondView?.tag = 5
        attackPerSecondView?.icon = #imageLiteral(resourceName: "attackPerSecond_icon.png") // attackPerSecond_icon.png
        
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
    
    private func createDAIconLabelView() -> DAIconLabelView {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnLabelView(_:)))
        
        let view = DAIconLabelView()
        view.iconPadding = 8
        view.iconSize = Layout.textAttachmentBounds.size
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        return view
    }
    
    @objc private func didTapOnLabelView(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view as? DAIconLabelView else {
            return
        }
        
        if let type = HeroBasicViewLabelType(rawValue: view.tag) {
            delegate?.heroBasicView(self, didTapOnLabelWithType: type)
        }
    }
    
}
