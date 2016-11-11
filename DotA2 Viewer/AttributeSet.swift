//
//  AttributeSet.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-11-11.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation

enum AttributeName: String {
    case intelligence = "Intelligence", agility = "Agility", strength = "Strength"
}

/*
 * Helps to hold data about a hero
 */
struct AttributeSet {
    var intelligence: Attribute!
    var agility: Attribute!
    var strength: Attribute!
    var primary: AttributeName!
    
    func isPrimaryAttribute(name: AttributeName) -> Bool{
        return name == primary
    }
}
