//
//  DAIconLabel.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-14.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

enum IconPosition {
    case left, right
}

class DAIconLabel: DAMainLabel {
    // MARK - Properties
    var position: IconPosition = .left { didSet { setText() } }
    var icon: UIImage? { didSet { setText() } }
    override var text: String? { didSet { setText() } }
    dynamic var normalText: String?
    
    // MARK - Methods
    fileprivate func setText() {
        normalText = self.text // used to keep track if empty string or not since there might be an icon
        let text = (self.text != nil && self.text != "") ? "\t\(self.text!)" : ""
        
        // create the icon (with offset so its in the middle)
        let attachment = NSTextAttachment()
        attachment.image = icon
        let attachmentText = NSAttributedString(attachment: attachment)
        attachment.bounds = CGRect(x: 0, y: self.font.descender, width: icon?.size.width ?? 0, height: icon?.size.height ?? 0)
        
        // create the text
        let normal = [NSFontAttributeName: UIFont(name: "Radiance", size: style.rawValue) as Any]
        let s1 = NSAttributedString(string: "\(text)", attributes: normal)
        
        // create the attribute string
        let attrText = NSMutableAttributedString()
        switch position {
        case .left:
            attrText.append(attachmentText)
            attrText.append(s1)
        default:
            attrText.append(s1)
            attrText.append(attachmentText)
        }
        
        // add to text
        self.attributedText = attrText
        
    }
}








































