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
    fileprivate var _details: [ItemDetail] { get { return _item.details?.allObjects as? [ItemDetail] ?? [ItemDetail]() } }
    
    
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
            _details.forEach({ details[$0.name ?? "Detail"] = convert($0.value?.array) })
            return details
        }
    }
    var availability: [String] { get { return convert(_item.availability?.allObjects) } }
    
    
    init(item: Item) {
        self._item = item
    }
    
    fileprivate func convert(_ arrayValue: [Any]?) -> [String] {
        let array = arrayValue as? [ArrayValue]
        return array?.map({ $0.value ?? "No Value" }) ?? [String]()
    }
    
}










































