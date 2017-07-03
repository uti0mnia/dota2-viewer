//
//  Ability+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData
import UIKit


public class Ability: NSManagedObject {
    public var specialIcons: NSAttributedString? {
        guard let specials = self.specials else {
            return nil
        }
        
        let finalString = NSMutableAttributedString()
        for special in specials {
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: special)
            attachment.bounds = Layout.textAttachmentBounds(for: Fonts.label)
            finalString.append(NSAttributedString(attachment: attachment))
        }
        
        return finalString
    }
    
    public var imageName: String {
        return String(format: "%@_%@", name.replacingOccurrences(of: ":", with: "_"), object.name)
    }
}
