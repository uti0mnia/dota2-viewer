//
//  HeroDetailsCell.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-13.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class HeroBasicCell: UITableViewCell {
    
    private(set) var kvView = KeyValueView()
    
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
        
        kvView.isVertical = false
        contentView.addSubview(kvView)
        
        kvView.snp.makeConstraints() { make in
            let edges = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            make.edges.equalTo(contentView).inset(edges)
        }
    }
}
