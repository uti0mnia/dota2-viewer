//
//  Item+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData
import UIKit


public class Item: Object {
    public var availabilityAttributedString: NSAttributedString? {
        guard let arrayItems = availability?.allObjects as? [ArrayItem] else {
            return nil
        }
        
        let finalString = NSMutableAttributedString()
        for arrayItem in arrayItems {
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: arrayItem.value)
            let string = NSAttributedString(attachment: attachment)
            finalString.append(string)
        }
        return finalString
    }
}
