//
//  AttributedStringParser.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-05.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import UIKit

class AttributedStringParser {
    
    public var attributedString: NSAttributedString?
    
    private init() {}
    
    public static func parse(string: String) -> NSAttributedString? {
        let characters = Array(string.characters)
        
        var currentString = ""
        let finalString = NSMutableAttributedString()
        
        var parsingImage = false
        
        // parse each charater
        for var i in 0..<characters.count {
            let char = characters[i]
            
            if char == "\\" {
                // we attempting to escape a char
                if i == characters.count - 1 || !(["$", "\\"].contains(characters[i+1])) {
                    print("Attributed Parsing Error: Illegal escape character.")
                    return nil
                } else {
                    currentString.append(characters[i+1])
                    i += 1
                }
            } else if char == "$" {
                if parsingImage {
                    if let imageString = createAttributedString(withImageName: currentString) {
                        finalString.append(imageString)
                    }
                } else {
                    let attrString = NSAttributedString(string: currentString)
                    finalString.append(attrString)
                }
                currentString = ""
                parsingImage = !parsingImage
            } else {
                currentString.append(char)
            }
        }
        
        // missing end of parsed image
        if parsingImage {
            print("Attributed Parsing Error: No image name closure")
            return nil
        }
        
        let attrString = NSAttributedString(string: currentString)
        finalString.append(attrString)
        return finalString
        
    }
    
    private static func createAttributedString(withImageName name: String) -> NSAttributedString? {
        if let image = UIImage(named: name) {
            let attachment = NSTextAttachment()
            attachment.image = image
            attachment.bounds = Layout.textAttachmentBounds(for: Fonts.label)
            return NSAttributedString(attachment: attachment)
        }
        return nil
    }
}
