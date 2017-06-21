//
//  Int+NumberHandling.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-20.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

extension Int {
    public var uti_nsDecimalValue: NSDecimalNumber {
        return NSDecimalNumber(value: self)
    }
    public var uti_doubleValue: Double {
        return Double(self)
    }
}
