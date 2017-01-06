//
//  ItemDetailModel.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-09.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ItemDetailModel {
    // MARK - Properties
    /* Private */
    fileprivate var _item: Item!
    fileprivate var _buildsInto: [Item]?
    fileprivate var _buildsFrom: [Item]?
    fileprivate var _needsRecipe = false
    fileprivate var _abilities: [Ability] { get { return _item.abilities?.array as? [Ability] ?? [Ability]() } }
    fileprivate var _itemDetails: [ItemDetail] { get { return _item.details?.allObjects as? [ItemDetail] ?? [ItemDetail]() } }
    
    
    /* Public */
    var name: String { get { return _item.name } }
    var image: UIImage { get { return _item.getImage() } }
    var cost: String { get { return _item.cost ?? "" } }
    var lore: String { get { return _item.lore ?? "" } }
    var type: String { get { return _item.type ?? "No Type" } }
    var typeImg: UIImage { get { return UIImage(named: type) ?? #imageLiteral(resourceName: "dota2.png") } }
    var abilities: [AbilityModel] { get { return _abilities.map({ AbilityModel(ability: $0) }) } }
    var additionalInfo: [String] { get { return convert(_item.additionalInfo?.allObjects) } }
    var additionalInfoPretty: String {
        get {
            var str = ""
            var separator = ""
            for item in additionalInfo {
                str += "\(separator)• \(item)"
                separator = "\n"
            }
            return str
        }
    }
    var availability: [String] { get { return convert(_item.availability?.allObjects) } }
    var availabilityPretty: NSAttributedString {
        get {
            // init the return string
            let string = NSMutableAttributedString()
            var spacing = ""
            
            // for each string create the image
            for str in availability {
                // create text attachment
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "\(str).png")
                
                let s0 = NSAttributedString(string: spacing)
                let s1 = NSAttributedString(attachment: attachment)
                string.append(s0)
                string.append(s1)
                
                // fix facing 
                spacing = "\t"
            }
            
            return string
        }
    }
    var buildsInto: [Item]? { get { return _buildsInto } }
    var buildsFrom: [Item]? { get { return _buildsFrom } }
    var details: [String: [String]] {
        get {
            var details = [String: [String]]()
            _itemDetails.forEach({ details[$0.name ?? "Detail"] = convert($0.value?.array) })
            return details
        }
    }
    var detailsString: NSAttributedString {
        get {
            // attributes
            let bold = [NSFontAttributeName : UIFont(name: "Radiance-Semibold", size: 17) as Any]
            let normal = [NSFontAttributeName: UIFont(name: "Radiance", size: 17) as Any]
            
            // attributed string that we will be returning
            let string = NSMutableAttributedString()
            var separator = ""
            for (k, v) in details {
                let key = NSAttributedString(string: separator + k, attributes: bold)
                let values = ": \(v.joined(separator: ", "))"
                let attrStr = NSAttributedString(string: values, attributes: normal)
                string.append(key)
                string.append(attrStr)
                separator = "\n" // set the separator to a new line for items 1..<n
            }
            return string
        }
    }
    var needsRecipe: Bool { get { return _needsRecipe } }
    var isSingularItem: Bool { get { return _buildsFrom == nil && _buildsInto == nil } }
    
    /* initializer that inits the item and the items that build into and from it if applicable. */
    init(item: Item) {
        self._item = item
        
        // create the builds into array that holds what the item can build into
        for name in item.buildsInto?.allObjects as? [ArrayValue] ?? [] {
            // can't build into a recipe so don't bother checking
            if let item = fetchItem(named: name.value ?? "") {
                if _buildsInto == nil { _buildsInto = [Item]() }
                _buildsInto?.append(item)
            }
        }
        
        // create the builds from array that holds what item's make up the item
        for name in item.buildsFrom?.allObjects as? [ArrayValue] ?? [] {
            // check if it's a recipe
            guard name.value != "Recipe" else {
                _needsRecipe = true
                continue
            }
            if let item = fetchItem(named: name.value ?? "") {
                if _buildsFrom == nil { _buildsFrom = [Item]() }
                _buildsFrom?.append(item)
            }
        }
    }
    
    /* tries to convert an array of Any into an [ArrayValue] and returns each item's value as [String] */
    fileprivate func convert(_ arrayValue: [Any]?) -> [String] {
        let array = arrayValue as? [ArrayValue]
        return array?.map({ $0.value ?? "No Value" }) ?? [String]()
    }
    
    
    /* tries to fetch an item with the given name and returns the first found (should always be unique) */
    fileprivate func fetchItem(named name: String) -> Item? {
        let predicate = NSPredicate(format: "name == %@", name)
        let fetch = NSFetchRequest<Item>(entityName: "Item")
        fetch.predicate = predicate
        let moc = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        do {
            let items = try moc.fetch(fetch)
            return items.first
        } catch {
            print("Error fetch item: \(error.localizedDescription)")
            return nil
        }
    }
    
}










































