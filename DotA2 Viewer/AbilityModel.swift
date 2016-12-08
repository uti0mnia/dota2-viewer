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
    fileprivate var _types: [AbilityType] { get { return _ability.type?.allObjects as? [AbilityType] ?? [AbilityType]() } }
    
    /* Public */
    var cooldown: String { get { return _ability.cooldown ?? "" } }
    var mana: String { get { return _ability.mana ?? "" } }
    var image: UIImage? { get { return _ability.image } }
    var name: String { get { return _ability.name ?? "No name" } }
    var summary: String { get { return _ability.summary ?? "No name" } }
    var specials: [String] { get { return convert(_ability.abilitySpecial?.allObjects) } }
    var data: [String] { get { return convert(_ability.data?.allObjects) } }
    var modifiers: [String] { get { return convert(_ability.modifiers?.allObjects) } }
    var notes: [Note] { get { return _ability.notes?.allObjects as? [Note] ?? [Note]() } }
    var types: [String: [String]] {
        get {
            var types = [String: [String]]()
            _types.forEach({ types[$0.type ?? "No Type"] = convert($0.value?.allObjects) })
            return types
        }
    }
    
    
    
    init(ability: Ability) {
        self._ability = ability
    }
    
    fileprivate func convert(_ arrayValue: [Any]?) -> [String] {
        let array = arrayValue as? [ArrayValue]
        return array?.map({ $0.value ?? "No Value" }) ?? [String]()
    }
}






































