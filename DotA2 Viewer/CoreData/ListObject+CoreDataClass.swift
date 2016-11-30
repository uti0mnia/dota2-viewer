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
        return UIImage(data: self.image as! Data) ?? #imageLiteral(resourceName: "default_icon.png")
    }
}
