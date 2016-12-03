//
//  DALoreLabel.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-11-13.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DALoreLabel: DAMultiLineLabel {

    init(frame: CGRect) {
        super.init(frame: frame, style: .small)
        commonInit()
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.textColor = UIColor.flatGray()
    }

}
