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
