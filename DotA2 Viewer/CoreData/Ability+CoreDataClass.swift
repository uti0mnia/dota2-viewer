//
//  Ability+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData
import UIKit


public class Ability: NSManagedObject {
    
    public static let specialDescriptions: Dictionary<String, String> =
        [
            // TODO: complete these
            "UNIQUE_ATTACK_MODIFIER": "Unique attack modifier.",
            "NO_PIERCE_SPELL_IMMUNE": "Doesn't pierce spell immunity.",
            "PARTIAL_PIERCE_SPELL_IMMUNE": "Partially pierces spell immunity.",
            "PIERCE_SPELL_IMMUNE": "Pierces spell immunity",
            "AGHANIM_UPGRADE": "Upgradable by Aghanim Scepter.",
            "DISABLED_BY_BREAK": "Disabled by break.",
            "PARTIAL_DISABLE": "Partially disabled by break.",
            "NOT_DISABLED_BY_BREAK": "Not disabled by break.",
            "NOT_UNIQUE_ATTACK_MODIFIER": "Not an unique attack modifier.",
            "ILLUSIONS_CANNOT_USE": "Illusions cannot use.",
            "ILLUSIONS_PARTIAL_USE": "Illusions can partially use.",
            "ILLUSIONS_CAN_USE": "Illusion can use.",
            "NOT_BLOCKED_BY_LINKEN": "Not blocked by Linken's Sphere",
            "PARTIAL_BLOCKED_BY_LINKEN": "Partially blocked by Linken's Sphere",
            "BLOCKED_BY_LINKEN":"Blocked by Linken's Sphere",
        ]
    
    public var specialIcons: NSAttributedString? {
        guard let specials = self.specials else {
            return nil
        }
        
        let finalString = "$" + specials.joined(separator: "$ $") + "$"
        return AttributedStringParser.parse(string: finalString)
    }
    
    public var imageName: String {
        return String(format: "%@_%@", name.replacingOccurrences(of: ":", with: "_"), object.name)
    }
}
