//
//  Layout.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-10.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class Layout {
    public static var abilityImageSize: CGSize {
        return CGSize(width: 128, height: 128)
    }
    
    public static var heroImageSize: CGSize {
        return CGSize(width: 256, height: 144)
    }
    
    public static var statusBarHeight: CGFloat {
        return 20
    }
    
    public static var objectImageMinimumHeight: CGFloat {
        return 64
    }
    
    public static func textAttachmentBounds(for font: UIFont) -> CGRect {
        return CGRect(x: 0, y: font.descender, width: 20, height: 20)
    }
    
}
