//
//  Item+CoreDataClass.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-15.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import CoreData

@objc(Item)
public class Item: ListObject {
    func getTypeImage() -> UIImage? {
        // make sure type isn't nil
        guard self.type != nil else { return nil }
        
        // create the image if we can
        let imgName = self.type! + ".png"
        if let img = UIImage(named: imgName) {
            return img
        }
        
        // weren't able to create image - return default image
        print("Failed to create item type image: \(imgName)")
        return nil
    }
    
}
