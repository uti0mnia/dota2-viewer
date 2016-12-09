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
    fileprivate var _abilities: [Ability] { get { return _item.abilities?.array as? [Ability] ?? [Ability]() } }
    fileprivate var _itemDetails: [ItemDetail] { get { return _item.details?.allObjects as? [ItemDetail] ?? [ItemDetail]() } }
    fileprivate var _buildsInto: [Item] {
        get {
            return convert(_item.buildsInto?.allObjects)
        }
    }
    fileprivate var _buildsFrom: [String] { get { return convert(_item.buildsFrom?.allObjects) } }
    
    
    /* Public */
    var name: String { get { return _item.name } }
    var image: UIImage { get { return _item.getImage() } }
    var cost: String { get { return _item.cost ?? "" } }
    var lore: String { get { return _item.lore ?? "" } }
    var type: String { get { return _item.type ?? "No Type" } }
    var typeImg: UIImage { get { return UIImage(named: type) ?? #imageLiteral(resourceName: "dota2-logo.png") } }
    var abilities: [AbilityModel] { get { return _abilities.map({ AbilityModel(ability: $0) }) } }
    var additionalInfo: [String] { get { return convert(_item.additionalInfo?.allObjects) } }
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
            let bold = [NSFontAttributeName : UIFont(name: "Radiance-Semibold", size: 17) ]
            let normal = [NSFontAttributeName: UIFont(name: "Radiance", size: 17)]
            
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
    var availability: [String] { get { return convert(_item.availability?.allObjects) } }
    var buildsInto: [Item] {
        get {
            
        }
    }
    
    
    init(item: Item) {
        self._item = item
    }
    
    fileprivate func convert(_ arrayValue: [Any]?) -> [String] {
        let array = arrayValue as? [ArrayValue]
        return array?.map({ $0.value ?? "No Value" }) ?? [String]()
    }
    
    fileprivate func item(named name: String) -> Item? {
        let fetch = NSFetchRequest<Item>(entityName: "Item")
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










































