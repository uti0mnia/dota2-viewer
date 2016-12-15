//
//  DAMainLabel.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-11-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import ChameleonFramework

enum DAMainLabelStyle: CGFloat {
    case xsmall = 12, small = 15, medium = 18, large = 24, xlarge = 30, title = 38
}

class DAMainLabel: UILabel {
    
    internal var style: DAMainLabelStyle = .medium
    internal var isBold: Bool = false
    
    init(frame: CGRect = CGRect(), style: DAMainLabelStyle = .medium, bold: Bool = false) {
        self.style = style
        self.isBold = bold
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        // set the text colour
        self.textColor = UIColor.flatWhite()
        
        // the font
        if isBold {
            self.font = UIFont(name: kRadianceBold.fontName, size: style.rawValue)
        } else {
            self.font = UIFont(name: kRadiance.fontName, size: style.rawValue)
        }
        
        // make sure the text fits
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
    }

}
