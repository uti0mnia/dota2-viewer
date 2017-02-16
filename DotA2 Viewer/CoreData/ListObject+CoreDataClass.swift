//
//  ListObject+CoreDataClass.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class ListObject: NSManagedObject {
    var image: UIImage? { get { return nil } }
    var details: NSAttributedString { get { return NSAttributedString() } }
    func firstLetter() -> String {
        self.willAccessValue(forKey: "firstLetter")
        let firstLetter = self.name.substring(to: self.name.index(after: self.name.startIndex)).uppercased()
        self.didAccessValue(forKey: "firstLetter")
        return firstLetter
    }
}
