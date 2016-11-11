//
//  DamageRange.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-11-11.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation

struct DamageRange {
    var min: Int
    var max: Int
    
    static func to(data: DamageRange) -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: data)
    }
    
    static func from(data: Data) -> DamageRange? {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? DamageRange
    }
}
