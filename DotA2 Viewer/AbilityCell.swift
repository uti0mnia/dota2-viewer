//
//  HeroAbilityCell.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-08.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class AbilityCell: UITableViewCell {
    
    private(set) var nameLabel = UILabel()
    private(set) var specialsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    private(set) var abilityImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private(set) var abilityStackView = AbilityCellStackView()
    override var selectionStyle: UITableViewCellSelectionStyle {
        get {
            return .none
        }
        set {
            self.selectionStyle = newValue
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        self.addSubviews([nameLabel, specialsLabel, abilityImageView, abilityStackView])
        
        nameLabel.snp.makeConstraints() { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(specialsLabel.snp.left)
        }
        
        specialsLabel.snp.makeConstraints() { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        abilityImageView.snp.makeConstraints() { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(abilityStackView)
            make.height.equalTo(Layout.abilityImageSize.height)
        }
        
        abilityStackView.snp.makeConstraints() { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    
    
}
