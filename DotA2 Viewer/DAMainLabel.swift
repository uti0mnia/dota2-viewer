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

@IBDesignable
class DAMainLabel: UILabel {
    
    @IBInspectable var style: DAMainLabelStyle = .medium
    
    init(frame: CGRect, style: DAMainLabelStyle = .medium) {
        super.init(frame: frame)
        self.style = style
        commonInit()
    }
    
    convenience init(style: DAMainLabelStyle = .medium) {
        self.init(frame: CGRect(), style: style)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        // set the text colour
        self.textColor = UIColor.flatWhite()
        
        // the font
        self.font = UIFont(name: kRadiance.fontName, size: style.rawValue)
        
        // make sure the text fits
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
    }

}
