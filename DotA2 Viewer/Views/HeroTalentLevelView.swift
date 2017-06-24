//
//  HeroTalentLevelView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-12.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class HeroTalentLevelView: UIView {
    
    private var levelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    public var level: Int = 0 {
        didSet {
            levelLabel.text = "\(level)"
            levelLabel.sizeToFit()
            levelLabel.center = self.center
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
    
    private func addLayer() {
        let layer = CAShapeLayer()
        var side: CGFloat!
        if self.bounds.width > self.bounds.height {
            side = self.bounds.height
            let offset = (self.bounds.width - self.bounds.height) / 2
            layer.frame = CGRect(x: offset, y: 0, width: side, height: side)
        } else {
            side = self.bounds.width
            let offset = (self.bounds.height - self.bounds.width) / 2
            layer.frame = CGRect(x: 0, y: offset, width: side, height: side)
        }
        
        layer.cornerRadius = side / 2
        
        // TODO: Add constants
        layer.backgroundColor = UIColor.blue.cgColor
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 3
        
        self.layer.insertSublayer(layer, at: 0)
        
        
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.clipsToBounds = true
    }
    
    private func commonInit() {
        addLayer()
        
        self.addSubview(levelLabel)
        
        levelLabel.snp.makeConstraints() { make in
            make.center.equalTo(self.snp.center)
        }
    }
    
}
