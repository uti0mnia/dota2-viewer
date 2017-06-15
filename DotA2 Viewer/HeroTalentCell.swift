//
//  HeroTalentCell.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-11.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class HeroTalentCell: UITableViewCell {
    private static let viewWidth: CGFloat = 50
    
    private(set) var leftLabel: UILabel!
    private(set) var rightLabel: UILabel!
    private(set) var levelView = HeroTalentLevelView()
    
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
        
        leftLabel = createLabel()
        rightLabel = createLabel()
        
        contentView.addSubviews([leftLabel, levelView, rightLabel])
        
        leftLabel.snp.makeConstraints() { make in
            make.left.equalTo(contentView)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
        
        levelView.snp.makeConstraints() { make in
            make.left.equalTo(leftLabel.snp.right)
            make.top.bottom.equalTo(contentView)
            make.right.equalTo(rightLabel.snp.left)
            make.width.equalTo(HeroTalentCell.viewWidth)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        rightLabel.snp.makeConstraints() { make in
            make.top.equalTo(contentView)
            make.right.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
}
