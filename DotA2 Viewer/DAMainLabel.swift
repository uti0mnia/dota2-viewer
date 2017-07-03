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
    case xsmall = 11, small = 15, medium = 19, large = 23, xlarge = 27, title = 31
    func shrink() -> DAMainLabelStyle {
        return DAMainLabelStyle(rawValue: self.rawValue - CGFloat(4)) ?? .xsmall
    }
    func enlarge() -> DAMainLabelStyle {
        return DAMainLabelStyle(rawValue: self.rawValue + CGFloat(4)) ?? .xlarge
    }
}

class DAMainLabel: DAPaddedLabel {
    
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
        self.textColor = UIColor.flatWhite
        
        // the font
        if isBold {
            self.font = UIFont(name: kRadianceBold.fontName, size: style.rawValue)
        } else {
            self.font = UIFont(name: kRadiance.fontName, size: style.rawValue)
        }
        
        // make sure the text fits
        self.adjustsFontSizeToFitWidth = true
    }

}
