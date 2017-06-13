//
//  HeroTalentLevelView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-11.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

public class HeroTalentLevelView: UIView {
    
    private(set) var levelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        // create a circle
        let center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        let radius = min(self.frame.width, self.frame.height) / 2
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        
        let layer = CAShapeLayer()
        layer.path = circlePath.cgPath
        
        layer.borderWidth = 2 // TODO: Add constants
        layer.borderColor = UIColor.flatRed().cgColor
        
        self.layer.addSublayer(layer)
    }
    
}
