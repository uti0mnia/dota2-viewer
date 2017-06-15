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
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        self.isUserInteractionEnabled = false
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, specialsLabel])
        stackView.distribution = .fillProportionally
        
//        contentView.addSubviews([stackView, abilityImageView, abilityStackView])
        contentView.addSubview(abilityStackView)
        abilityStackView.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalTo(contentView)
        }
        
//        stackView.snp.makeConstraints() { make in
//            make.left.top.right.equalTo(contentView)
//        }
//        
//        abilityImageView.snp.makeConstraints() { make in
//            make.left.right.bottom.equalTo(contentView)
//            make.top.equalTo(stackView.snp.bottom)
//            make.bottom.equalTo(abilityStackView.snp.top)
//            make.height.equalTo(Layout.abilityImageSize.height)
//        }
        
//        abilityStackView.snp.makeConstraints() { make in
//            make.left.bottom.right.equalTo(contentView)
//        }
    }
}
