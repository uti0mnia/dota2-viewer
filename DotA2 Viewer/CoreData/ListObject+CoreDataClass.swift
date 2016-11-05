//
//  ListObject+CoreDataClass.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-15.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import CoreData


public class ListObject: NSManagedObject {
    func objectImage() -> UIImage? { return nil }
    func firstLetter() -> String {
        self.willAccessValue(forKey: "firstLetter")
        let firstLetter = self.name.substring(to: self.name.index(after: self.name.startIndex)).uppercased()
        self.didAccessValue(forKey: "firstLetter")
        return firstLetter
    }
}
