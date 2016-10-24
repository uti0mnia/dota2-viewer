//
//  Extensions.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-23.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setHeight(_ height: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: height)
    }
    
    func setWidth(_ width: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width , height: self.frame.height)
    }
}
