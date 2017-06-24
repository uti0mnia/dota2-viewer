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
    private static let viewHeight: CGFloat = 50
    
    private(set) var leftLabel = UILabel()
    private(set) var rightLabel = UILabel()
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
        
        leftLabel.textAlignment = .left
        leftLabel.numberOfLines = 0
        rightLabel.textAlignment = .right
        rightLabel.numberOfLines = 0
        
        contentView.uti_addSubviews([leftLabel, levelView, rightLabel])
        
        leftLabel.snp.makeConstraints() { make in
            make.left.bottom.equalTo(contentView).inset(8)
            make.right.equalTo(rightLabel.snp.left).offset(-8)
            make.width.equalTo(contentView.snp.width).dividedBy(2)
        }
        
        levelView.snp.makeConstraints() { make in
            make.left.top.right.equalTo(contentView)
            make.height.equalTo(HeroTalentCell.viewHeight)
            make.bottom.equalTo(leftLabel.snp.top)
        }
        
        rightLabel.snp.makeConstraints() { make in
            make.right.bottom.equalTo(contentView).inset(8)
        }
    }
    
}
