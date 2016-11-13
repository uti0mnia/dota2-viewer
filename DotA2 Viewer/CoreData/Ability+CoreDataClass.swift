//
//  Ability+CoreDataClass.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-15.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import CoreData

@objc(Ability)
public class Ability: NSManagedObject {
    func getImage() -> UIImage? {
        // make sure name isn't nil
        guard self.name != nil && self.hero != nil else { return nil }
        
        let imgName = self.name!.replacingOccurrences(of: " ", with: "-") + "_" + self.hero!.name!
        if let img = UIImage(named: imgName) {
            return img
        }
        
        print("Failed to create image for ability: \(imgName)") 
        return nil
    }
}
