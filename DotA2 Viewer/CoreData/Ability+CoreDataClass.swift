//
//  Ability+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2016-11-30.
//
//

import Foundation
import UIKit
import CoreData

@objc(Ability)
public class Ability: NSManagedObject {
    var image: UIImage? {
        get {
            let name = String(format: "%@_%@.png", self.name ?? "", self.hero?.name ?? "")
            return UIImage(named: name)
        }
    }
}
