//
//  Attribute+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2016-11-30.
//
//

import Foundation
import CoreData
import UIKit

@objc(Attribute)
public class Attribute: NSManagedObject {
    var image: UIImage { get { return UIImage(named: "\(self.name!.lowercased())_icon.png") ?? #imageLiteral(resourceName: "strength_icon.png") } }
}
