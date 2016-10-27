//
//  Hero+CoreDataClass.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-15.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import CoreData

@objc(Hero)
public class Hero: ListObject {
    override func objectImage() -> UIImage? {
        let imgName = self.name! + ".png"
        if let img = UIImage(named: imgName) {
            return img
        } else {
            return #imageLiteral(resourceName: "default_icon.png")
        }
        
        //print("Failed to create image for hero: \(imgName)")
        //return nil
    }
}
