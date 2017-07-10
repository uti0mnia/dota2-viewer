//
//  HeroMiscCell.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-12.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class HeroMiscCell: UITableViewCell {
    
    // TODO: Make label subclass for this.
    private(set) var mainLabel: DALabel = {
        let label = DALabel()
        label.style = .title
        label.textAlignment = .center
        return label
    }()
    private(set) var subLabel: DALabel = {
        // TODO: Make NSParagraphStyle for this
        let label = DALabel()
        label.style = .text
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        isUserInteractionEnabled = false
        
        backgroundColor = UIColor.clear
        
        contentView.u0_addSubviews([mainLabel, subLabel])
        
        mainLabel.snp.makeConstraints() { make in
            make.left.top.right.equalTo(contentView).inset(8)
            make.bottom.equalTo(subLabel.snp.top).offset(-8)
        }
        
        subLabel.snp.makeConstraints() { make in
            make.left.bottom.right.equalTo(contentView).inset(8)
        }
        
    }
    
}
