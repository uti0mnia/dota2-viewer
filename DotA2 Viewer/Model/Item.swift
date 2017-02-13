//
//  Item.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-12.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

class Item {
    // properties
    private(set) var abilities: [Ability]
    private(set) var additionalInfo: [String]
    private(set) var cost: (Int, Int?)
    private(set) var details: [String: [String]]
    private(set) var lore: String
    private(set) var type: String
    private(set) var availability: [String]
    
}
