//
//  Note+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


public class Note: NSManagedObject {
    public func prettify(depth: Int = 0) -> NSAttributedString {
        var tabs = String(repeating: "\t", count: depth)
        tabs += "•"
        let currentNote = AttributedStringParser.parse(string: tabs + value)!
        let finalString = NSMutableAttributedString(attributedString: currentNote)
        
        if let subnotes = subnotes?.array as? [Note] {
            for subnote in subnotes {
                let subnoteString = subnote.prettify(depth: depth + 1)
                finalString.append(NSAttributedString.newLine)
                finalString.append(subnoteString)
            }
        }
        
        return finalString
    }
}
