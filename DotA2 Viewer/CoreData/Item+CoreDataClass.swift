//
//  Item+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2016-11-30.
//
//

import Foundation
import UIKit
import CoreData

@objc(Item)
public class Item: ListObject {
    override var detailPretty: NSAttributedString {
        get {
            // create coin attachment
            let attachment = NSTextAttachment()
            attachment.image = #imageLiteral(resourceName: "coins.png") // coins.png
            attachment.bounds = CGRect(x: 0, y: kRadiance.descender, width: #imageLiteral(resourceName: "coins.png").size.width, height: #imageLiteral(resourceName: "coins.png").size.height)
            
            // create both strings
            let coinStr = NSAttributedString(attachment: attachment)
            let costStr = NSAttributedString(string: "\t\(self.cost!)")
            
            // setup return string
            let string = NSMutableAttributedString(attributedString: coinStr)
            string.append(costStr)
            return string
        }
    }
}
