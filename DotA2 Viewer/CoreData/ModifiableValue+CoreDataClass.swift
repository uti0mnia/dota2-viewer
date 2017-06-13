//
//  ModifiableValue+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


public class ModifiableValue: NSManagedObject {
    public func getFullAttributedString() -> NSMutableAttributedString {
        let finalString = NSMutableAttributedString()
        finalString.append(getNameAttributedString())
        finalString.append(NSAttributedString(string: ": "))
        finalString.append(getValuesAttributedString())
        return finalString
    }
    
    public func getNameAttributedString() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self.name)
    }
    
    public func getValuesAttributedString() -> NSMutableAttributedString {
        var string = "\(self.normal)"
        if let talent = self.talent {
            string += " ($\(StringIcons.TalentUpgrade)$ \(talent))"
        }
        if let aghs = self.aghs {
            string += " ($\(StringIcons.AghanimUpgrade)$ \(aghs)"
            if let aghsAndTalent = self.aghsAndTalent {
                string += ", $\(StringIcons.TalentUpgrade)$ \(aghsAndTalent))"
            } else {
                string += ")"
            }
        }
        
        let attString = AttributedStringParser.parse(string: string)!
        return NSMutableAttributedString(attributedString: attString)
    }
}
