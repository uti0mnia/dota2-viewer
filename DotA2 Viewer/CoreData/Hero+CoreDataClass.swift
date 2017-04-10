//
//  Hero+CoreDataClass.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Hero)
public class Hero: ListObject {
    override var image: UIImage? {
        get {
            return UIImage(named: name + ".png")
        }
    }
}
