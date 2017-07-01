//
//  Object+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


public class Object: NSManagedObject {
    
    public func firstLetter() -> String {
        self.willAccessValue(forKey: "firstLetter")
        let firstLetter = self.name.substring(to: self.name.index(after: self.name.startIndex)).uppercased()
        self.didAccessValue(forKey: "firstLetter")
        return firstLetter
    }
    
    public var imageName: String {
        return name.replacingOccurrences(of: ":", with: "_") + ".png"
    }
    
    public static func imageNameFrom(_ name: String) -> String {
        return name.replacingOccurrences(of: ":", with: "_") + ".png"
    }
}
