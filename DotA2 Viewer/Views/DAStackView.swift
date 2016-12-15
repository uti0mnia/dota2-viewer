//
//  DAStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-14.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DAStackView: UIStackView {
    // MARK - Properties
    private var colour: UIColor?
    override var backgroundColor: UIColor? {
        get { return colour }
        set { colour = newValue }
    }
    
    private lazy var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
        backgroundLayer.fillColor = self.backgroundColor?.cgColor
    }

}
