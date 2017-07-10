//
//  DALabel.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-06.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class DALabel: UILabel {
    
    public enum Style {
        case title, subtitle, text
        
        public var font: UIFont {
            switch self {
            case .title:
                return Fonts.title
            case .subtitle:
                return Fonts.subtitle
            case .text:
                return Fonts.text
            }
        }
    }
    
    @IBInspectable public var style: Style = .title {
        didSet {
            font = style.font
        }
    }
    
    convenience init(style: Style) {
        self.init()
        
        defer {
            self.style = style
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
    
    public func commonInit() {
        textColor = Colours.secondaryColour
    }
}
