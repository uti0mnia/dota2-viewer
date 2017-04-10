//
//  AbilityModel.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-08.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AbilityModel {
    // MARK - Properties
    /* Private */
    fileprivate var _ability: Ability!
    fileprivate var _types: [AbilityTuple] { get { return _ability.types?.allObjects as? [AbilityTuple] ?? [AbilityTuple]() } }
    
    /* Public */
    var cooldown: NSAttributedString {
        get {
            let attString = NSAttributedString()
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "cooldown.png")
        }
    }
    var mana: String { get { return _ability.mana ?? "" } }
    var image: UIImage? { get { return _ability.image } }
    var name: String { get { return _ability.name ?? "No name" } }
    var summary: String { get { return _ability.summary ?? "No name" } }
    var specials: [String] { get { return convert(_ability.abilitySpecial?.allObjects) } }
    var specialsPretty: NSAttributedString {
        // create return attribute string
        let string = NSMutableAttributedString(string: " ")
        var separator = "  "
        for special in specials {
            // create the attachment and spacing
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "\(special).png")
            let size = attachment.image?.size ?? CGSize.zero
            attachment.bounds = CGRect(x: 0, y: kRadiance.descender, width: size.width, height: size.height)
            
            // create the attributed strings and append
            let s1 = NSAttributedString(string: separator)
            let s2 = NSAttributedString(attachment: attachment)
            string.append(s1)
            string.append(s2)
            
            //change the separator
            separator = "  "
        }
        return string
        
    }
    var specialDetails: [String] { get { return convert(_ability.specialDetails?.allObjects) } }
    var specialDetailsPretty: NSAttributedString {
        // create the return string
        let string = NSMutableAttributedString()
        
        // separator
        var separator = ""
        
        for special in specialDetails {
            // split the 2 parts
            let parts = special.characters.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true).map(String.init)
            
            // create the attributed string
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "\(parts[0]).png")
            attachment.bounds = CGRect(x: 0, y: kRadiance.descender, width: attachment.image?.size.width ?? 0, height: attachment.image?.size.height ?? 0)
            let s0 = NSAttributedString(string: separator)
            let s1 = NSAttributedString(attachment: attachment)
            let s2 = NSAttributedString(string: " \(parts[1])")
            
            // append the newly created string
            string.append(s0)
            string.append(s1)
            string.append(s2)
            
            // change the separator (for the first time)
            separator = "\n"
        }
        
        return string
    }
    var data: [String] { get { return convert(_ability.data?.allObjects) } }
    var dataPretty: NSAttributedString {
        get {
            // return string
            let string = NSMutableAttributedString()
            
            // attributes
            let bold = [NSFontAttributeName : UIFont(name: "Radiance-Semibold", size: 17) as Any]
            let normal = [NSFontAttributeName: UIFont(name: "Radiance", size: 17) as Any]
            
            // separator
            var separator = ""
            for d in data {
                // split the 2 parts of the data
                let split = d.components(separatedBy: ":")
                
                // create the 2 parts, one bold one normal
                let s1 = NSAttributedString(string: "\(separator)• \(split[0])", attributes: bold)
                let s2 = NSAttributedString(string: ": \(split[1])", attributes: normal)
                
                // append to return string
                string.append(s1)
                string.append(s2)
                
                // set the separator (for the first loop)
                separator = "\n"
            }
            
            return string
        }
    }
    var modifiers: [String] { get { return convert(_ability.modifiers?.allObjects) } }
    var notes: [Note] { get { return _ability.notes?.array as? [Note] ?? [Note]() } }
    var notesPretty: String { get { return print(notes: notes) } }
    var types: [String: [String]] {
        get {
            var types = [String: [String]]()
            _types.forEach({ types[$0.type ?? "No Type"] = convert($0.value?.allObjects) })
            return types
        }
    }
    var typesPrettyPrint: NSAttributedString {
        get {
            // return string
            let string = NSMutableAttributedString()
            
            // attributes
            let bold = [NSFontAttributeName : UIFont(name: "Radiance-Semibold", size: 17) as Any]
            
            // separator
            var separator = ""
            for (key, value) in types {
                // try to create an aghs image (for certain abilities)
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "\(value).png")
                // create the attribute strings
                let s1 = NSAttributedString(string: "\(separator)\(key)\n", attributes: bold)
                let s2 = getStringFrom(typesValues: value)
                
                // add them
                string.append(s1)
                string.append(s2)
                
                // change separator for the first time
                separator = "\n"
            }
            
            return string
        }
    }
    
    init(ability: Ability) {
        self._ability = ability
    }
    
    fileprivate func convert(_ arrayValue: [Any]?) -> [String] {
        let array = arrayValue as? [ArrayValue]
        return array?.map({ $0.value ?? "No Value" }) ?? [String]()
    }
    
    fileprivate func print(notes: [Note], withCurrentString string: String = "", andIndent indent: Int = 0, initial: Bool = true) -> String {
        // base case
        if notes.count == 0 {
            return string
        }
        
        let note = notes[0]
        let newLine = initial ? "" : "\n"
        let tab = String(repeating: "\t", count: indent)
        var newString = string + "\(newLine)\(tab)• \(note.string ?? "No Note")"
        
        // check if there's a subnote
        if let array = note.subNotes?.array as? [Note] {
            newString += print(notes: array, withCurrentString: "", andIndent: indent + 1, initial: false)
        }
        
        
        let newNotes = Array<Note>(notes[1..<notes.count])
        return print(notes: newNotes, withCurrentString: newString, andIndent: indent, initial: false)
        
    }
    
    fileprivate func getStringFrom(typesValues values: [String]) -> NSAttributedString {
        let string = NSMutableAttributedString()
        
        let normal = [NSFontAttributeName: UIFont(name: "Radiance", size: 17) as Any]
        
        var separator = ""
        for value in values {
            var split = value.components(separatedBy: " ")
            if let image = UIImage(named: "\(split.remove(at: 0)).png") {
                // create the attachment
                let attachment = NSTextAttachment()
                attachment.image = image
                attachment.bounds = CGRect(x: 0, y: kRadiance.descender, width: image.size.width, height: image.size.height)
                
                // create the string
                let s1 = NSAttributedString(attachment: attachment)
                let s2 = NSAttributedString(string: "\(separator) \(split.joined(separator: " "))", attributes: normal)
                
                // append the strings
                string.append(s1)
                string.append(s2)
            } else {
                let s1 = NSAttributedString(string: "\(separator)\(value)", attributes: normal)
                string.append(s1)
            }
            
            separator = "\n"
        }
        
        return string
    }
}






































