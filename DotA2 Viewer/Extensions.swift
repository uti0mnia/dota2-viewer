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

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UIStackView {
    func addArrangedSubviews(views: [UIView?]) {
        for view in views {
            if view == nil { continue }
            self.addArrangedSubview(view!)
        }
    }
}

extension Int {    
    var nsDecimalValue: NSDecimalNumber { get { return NSDecimalNumber(value: self) } }
    var doubleValue: Double { get { return Double(self) } }
}

extension Double {
    func format(_ digits: Int) -> String {
        return String(format: "%.\(digits)f", self)
    }
}




































