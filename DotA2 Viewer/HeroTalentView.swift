//
//  HeroTalentView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-04.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class HeroTalentView: UIView {
    
    private var titleStackView = DATitleStackView()
    private var leftLabel = DALabel()
    private var rightLabel = DALabel()
    
    public var talent: Talent? {
        didSet {
            guard let talent = talent else {
                return
            }
            
            titleStackView.title = "Level \(talent.level)"
            leftLabel.text = talent.left
            rightLabel.text = talent.right
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
        leftLabel.numberOfLines = 0
        leftLabel.textAlignment = .left
        
        rightLabel.numberOfLines = 0
        rightLabel.textAlignment = .right
        
        let stackView = UIStackView(arrangedSubviews: [leftLabel, rightLabel])
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        
        titleStackView.setDetailView(stackView)
        
        addSubview(titleStackView)
        
        titleStackView.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalTo(self)
        }
    }
}
