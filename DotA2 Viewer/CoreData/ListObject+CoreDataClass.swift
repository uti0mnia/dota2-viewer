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
    func getImage() -> UIImage {
        guard (self.image != nil) else { return #imageLiteral(resourceName: "default_icon.png") }
        if let img = NSKeyedUnarchiver.unarchiveObject(with: self.image as! Data) as? UIImage {
            return img
        } else {
            return #imageLiteral(resourceName: "default_icon.png")
        }
    }
}
