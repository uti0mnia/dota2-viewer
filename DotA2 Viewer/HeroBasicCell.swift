//
//  HeroDetailsCell.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-13.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class HeroBasicCell: UITableViewCell {
    private(set) var kvView: KeyValueView = {
        let view = KeyValueView()
        view.orientation = .horizontal
        return view
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
        self.contentView.addSubview(kvView)
        
        kvView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        kvView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        kvView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        kvView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
