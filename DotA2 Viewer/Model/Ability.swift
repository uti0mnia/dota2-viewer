//
//  Ability.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-12.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

class Ability {
	// Ability data structutres
    enum DataType: String { case normal = "normal", aghanim = "AGHANIM_UPGRADE", talent = "TALENT", talent_aghs = "TALENT_AGHS" }
    private struct DataItem {
        var normal: String?
        var aghs: String?
        var talent: String?
        var talent_aghs: String?
    }
    
    // properties
    private(set) var name: String
    private(set) var modifiers: [(String, Bool)] // string is modifier, bool is true <=> green, false <=> red
    private(set) var description: String
    private(set) var mana: DataItem
    private(set) var abilitySpecial: [String]
    private(set) var notes: [Note]
    private(set) var specialDetails: [String: String]
    private(set) var cooldown: DataItem
    private(set) var data: [String: DataItem]
    private(set) var types: [String: DataItem]
}
