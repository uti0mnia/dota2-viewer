//
//  HeroAttributeSlider.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-14.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class HeroAttributeSlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        self.value = 1
        self.minimumValue = 1
        self.maximumValue = 25
    }
    
}
