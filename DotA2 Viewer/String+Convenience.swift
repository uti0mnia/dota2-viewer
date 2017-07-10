//
//  String+Convenience.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-20.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

extension String {
    public var u0_capitalized: String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
}
