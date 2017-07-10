//
//  Int+NumberHandling.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-20.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

extension Int {
    public var u0_nsDecimalValue: NSDecimalNumber {
        return NSDecimalNumber(value: self)
    }
    public var u0_doubleValue: Double {
        return Double(self)
    }
}
