//
//  Fonts.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-06.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import UIKit

class Fonts {
    private init() {}
    
    public static var titleSize: CGFloat {
        return 20
    }
    
    public static var labelSize: CGFloat {
        return 16
    }
    
    public static var subLabelSize: CGFloat {
        return 14
    }
    
    public static var title: UIFont {
        return UIFont.boldSystemFont(ofSize: Fonts.titleSize)
    }
    
    public static var label: UIFont {
        return UIFont.systemFont(ofSize: Fonts.labelSize)
    }
    
    public static var subLabel: UIFont {
        return UIFont.systemFont(ofSize: Fonts.subLabelSize)
    }
    
    public static var boldLabel: UIFont {
        return UIFont.boldSystemFont(ofSize: Fonts.labelSize)
    }
    
    public static var boldLabelAttribute: [String: Any] {
        return [NSFontAttributeName: Fonts.boldLabel]
    }
    
    
}
