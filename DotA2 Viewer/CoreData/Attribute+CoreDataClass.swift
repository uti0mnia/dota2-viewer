//
//  Attribute+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


public enum HeroAttribute: String {
    case intelligence = "intelligence"
    case agility = "agility"
    case strength = "strength"
}

public class Attribute: NSManagedObject {
    var heroAttribute: HeroAttribute {
            if type == 0 {
                return .intelligence
            } else if type == 1 {
                return .agility
            } else {
                return .strength
            }
    }

}
