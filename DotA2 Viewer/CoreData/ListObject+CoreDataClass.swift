//
//  ListObject+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2016-11-30.
//
//

import Foundation
import UIKit
import CoreData


public class ListObject: NSManagedObject {
    func getImage() -> UIImage {
        let name = String(format: "%@.png", self.name)
        return UIImage(named: name) ?? #imageLiteral(resourceName: "default_icon.png")
    }
    
    func firstLetter() -> String {
        self.willAccessValue(forKey: "firstLetter")
        let firstLetter = self.name.substring(to: self.name.index(after: self.name.startIndex)).uppercased()
        self.didAccessValue(forKey: "firstLetter")
        return firstLetter
    }
}
