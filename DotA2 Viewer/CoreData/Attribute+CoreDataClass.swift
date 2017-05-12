//
//  Attribute+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


public class Attribute: NSManagedObject {
    var typeString: String {
        get {
            if type == 0 {
                return "intelligence"
            } else if type == 1 {
                return "agility"
            } else {
                return "strength"
            }
        }
    }

}
