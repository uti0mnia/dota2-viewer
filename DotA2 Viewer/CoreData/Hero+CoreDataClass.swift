//
//  Hero+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2016-11-30.
//
//

import Foundation
import UIKit
import CoreData

@objc(Hero)
public class Hero: ListObject {
    override var detailPretty: NSAttributedString {
        get {
            let string = NSMutableAttributedString()
            let bold = [NSFontAttributeName : UIFont(name: "Radiance-Semibold", size: 15)]
            
            // create primary attribute image
            let attributes = self.attribute?.allObjects as! [Attribute]
            let primary = attributes.filter({ $0.isPrimary == 1 })[0]
            let attachment = NSTextAttachment()
            attachment.image = primary.image
            attachment.bounds = CGRect(x: 0, y: kRadiance.descender, width: 20, height: 20)
            let s2 = NSAttributedString(attachment: attachment)
            string.append(s2)
            
            // create attack type
            let attackType = ((self.miscStats?.projectileSpeed ?? "") == "Instant") ? " | Melee" : " | Ranged"
            let s1 = NSAttributedString(string: attackType, attributes: bold)
            string.append(s1)
            
            return string
        }
    }
}
