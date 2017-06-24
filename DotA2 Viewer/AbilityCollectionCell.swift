//
//  AbilityCollectionCell.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-23.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class AbilityCollectionCell: UICollectionViewCell {
    
    private var scrollView = UIScrollView()
    private var abilityView = AbilityView()
    
    public var ability: Ability? {
        didSet {
            guard let ability = ability else {
                return
            }
            
            abilityView.name = ability.name
            abilityView.specials = ability.specialIcons
            abilityView.abilityImage = UIImage(named: ability.imageName)
            abilityView.abilityDescription = ability.descrip
            abilityView.types = ability.types?.array as? [ModifiableValue]
            abilityView.data = ability.data?.array as? [ModifiableValue]
            abilityView.modifiers = ability.modifiers?.allObjects as? [Modifier]
            abilityView.cooldown = ability.cooldown
            abilityView.mana = ability.mana
            abilityView.notes = ability.notes?.array as? [Note]
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalTo(contentView)
        }
        
        scrollView.addSubview(abilityView)
        abilityView.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalTo(scrollView)
            make.width.equalTo(contentView.snp.width)
        }
    }
}
