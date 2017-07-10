//
//  Double+StringFormat.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-31.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

extension Double {
    // allows user to create a string from a Decimal with a number of decimals
    public func u0_string(_ decimals: Int) -> String {
        return String(format: "%.\(decimals)f", self)
    }
}
