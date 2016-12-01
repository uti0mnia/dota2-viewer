//
//  FirebaseExport.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-11-24.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation
import Firebase
import CoreData

struct FirebaseImport {
    
    /* This function is meant to create abilities from the abilities in the firebase db */
    static private func createAbilities(with abilities: [[String: [String : Any]]], inContext moc: NSManagedObjectContext) -> [Ability] {
        var heroAbilities = [Ability]()
        for obj in abilities {
        // get the name of the ability
        let name = obj.first!.key
        
        // create a NSManagedObject
        let ability = NSEntityDescription.insertNewObject(forEntityName: "Ability", into: moc) as! Ability
        ability.name = name
        ability.cooldown = obj[name]?["Cooldown"] as? String
        ability.mana = obj[name]?["Mana"] as? String
        
        // get the specials
        var abilitySpecials = [ArrayValue]()
        for special in obj[name]?["abilitySpecial"] as! [String] {
        let abilitySpecial = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
        abilitySpecial.value = special
        abilitySpecials.append(abilitySpecial)
        }
        ability.abilitySpecial = NSSet(array: abilitySpecials)
        
        // get the data for the ability
        var abilityDatas = [ArrayValue]()
        for data in obj[name]?["data"] as! [String] {
        let abilityData = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
        abilityData.value = data
        abilityDatas.append(abilityData)
        }
        ability.data = NSSet(array: abilityDatas)
        
        // if the ability has modifiers, add them
        if obj[name]?["modifiers"] != nil {
        var abilityModifiers = [ArrayValue]()
        for modifier in obj[name]?["modifiers"] as! [String] {
        let abilityModifier = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
        abilityModifier.value = modifier
        abilityModifiers.append(abilityModifier)
        }
        ability.modifiers = NSSet(array: abilityModifiers)
        }
        
        // if the ability has notes, add them
        if obj[name]?["notes"] != nil {
        let notes = createNote(from: obj[name]?["notes"] as! [Any], inContext: moc, notes: [Note]())
        ability.notes = NSSet(array: notes)
        }
        
        heroAbilities.append(ability)
        }
        
        return heroAbilities
    }
    
    /* This function is meant to create notes/subnotes from the notes in the firebase db */
    static private func createNote(from array: [Any], inContext moc: NSManagedObjectContext, notes: [Note]) -> [Note] {
        // base case
        if array.count == 0 {
            return notes
        }
        
        // array case
        if let subArray = array[0] as? [Any] {
            let subNotes = createNote(from: subArray, inContext: moc, notes: [Note]())
            notes.last?.subnote = NSOrderedSet(array: subNotes)
            let newArray = Array<Any>(array[1..<array.count])
            return createNote(from: newArray, inContext: moc, notes: notes)
        }
        
        // string case
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: moc) as! Note
        note.note = array[0] as? String
        let newNotes = notes + [note]
        let newArray = Array<Any>(array[1..<array.count])
        return createNote(from: newArray, inContext: moc, notes: newNotes)
        
    }
    
    /* This function is meant to insert a Hero object into the object context */
    static private func insertHero(from snapshot: FIRDataSnapshot, inContext moc: NSManagedObjectContext) {
        // create hero entity
        let hero = NSEntityDescription.insertNewObject(forEntityName: "Hero", into: moc) as! Hero
        // get the snapshot value (JSON)
        let snapshotValue = snapshot.value as! [String: AnyObject]
        hero.name = snapshot.key
        
        // set values
        hero.summary = snapshotValue["description"] as? String
        hero.lore = snapshotValue["lore"] as? String
        
        // get the roles
        var roles = [ArrayValue]()
        for val in snapshotValue["roles"] as! [String] {
            let role = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
            role.value = val
            roles.append(role)
        }
        hero.roles = NSSet(array: roles)
        
        // get misc stats
        let miscStat = NSEntityDescription.insertNewObject(forEntityName: "MiscStat", into: moc) as! MiscStat
        miscStat.attackAnimation = snapshotValue["misc_stats"]?["Attack Animation"] as? String
        miscStat.attackRange = NSDecimalNumber(string: snapshotValue["misc_stats"]?["Attack Range"] as? String)
        miscStat.attackTime = NSDecimalNumber(string: snapshotValue["misc_stats"]?["Base Attack Time"] as? String)
        miscStat.collisionSize = NSDecimalNumber(string: snapshotValue["misc_stats"]?["Collision Size"] as? String)
        miscStat.magicResistance = NSDecimalNumber(string: snapshotValue["misc_stats"]?["Magic resistance"] as? String)
        miscStat.movementSpeed = NSDecimalNumber(string: snapshotValue["misc_stats"]?["Movement Speed"] as? String)
        miscStat.projectileSpeed = snapshotValue["misc_stats"]?["Projectile Speed"] as? String
        miscStat.turnRate = NSDecimalNumber(string: snapshotValue["misc_stats"]?["Turn Rate"] as? String)
        miscStat.visionRange = snapshotValue["misc_stats"]?["Vision Range"] as? String
        hero.miscStats = miscStat
        
        // get base stats
        let baseStat = NSEntityDescription.insertNewObject(forEntityName: "BaseStat", into: moc) as! BaseStat
        baseStat.armor = NSDecimalNumber(string: snapshotValue["base_stats"]?["armor"] as? String)
        baseStat.attackPerS = NSDecimalNumber(string: snapshotValue["base_stats"]?["attack_s"] as? String)
        let damage = NSEntityDescription.insertNewObject(forEntityName: "Damage", into: moc) as! Damage
        damage.min = NSDecimalNumber(string: (snapshotValue["base_stats"]?["damage"] as? [String: String])?["min"])
        damage.max = NSDecimalNumber(string: (snapshotValue["base_stats"]?["damage"] as? [String: String])?["max"])
        baseStat.damage = damage
        baseStat.hp = NSDecimalNumber(string: snapshotValue["base_stats"]?["hp"] as? String)
        baseStat.hpRegen = NSDecimalNumber(string: snapshotValue["base_stats"]?["hp_regen"] as? String)
        baseStat.mana = NSDecimalNumber(string: snapshotValue["base_stats"]?["mana"] as? String)
        baseStat.manaRegen = NSDecimalNumber(string: snapshotValue["base_stats"]?["mana_regen"] as? String)
        baseStat.spellDamage = NSDecimalNumber(string: snapshotValue["base_stats"]?["spell_damage"] as? String)
        hero.baseStats = baseStat
        
        // get attributes
        let attributes = ["Agility", "Intelligence", "Strength"]
        var heroAttributes = [Attribute]()
        for attr in attributes {
            let val = snapshotValue["attributes"]![attr] as! [String: Any]
            let attribute = NSEntityDescription.insertNewObject(forEntityName: "Attribute", into: moc) as! Attribute
            attribute.base = NSDecimalNumber(string: val["base"] as? String)
            attribute.increment = NSDecimalNumber(string: val["incerment"] as? String)
            attribute.isPrimary = NSDecimalNumber(string: val["primary"] as? String)
            heroAttributes.append(attribute)
        }
        hero.attribute = NSSet(array: heroAttributes)
        
        // get abilities
        let abilities = snapshotValue["abilities"] as! [[String: [String: Any]]]
        let heroAbilities = createAbilities(with: abilities, inContext: moc)
        hero.abilities = NSOrderedSet(array: heroAbilities)
    }
    
    /* This function is meant to insert a Hero object into the object context */
    static private func insertItem(from snapshot: FIRDataSnapshot, inContext moc: NSManagedObjectContext) {
        // insert new item entity
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: moc) as! Item
        
        // get the snapshot value (JSON)
        let snapshotValue = snapshot.value as! [String: AnyObject]
        item.name = snapshot.key
        
        // set simple values
        item.cost = snapshotValue["cost"] as? String
        item.lore = snapshotValue["lore"] as? String
        item.type = snapshotValue["type"] as? String
        
        // set the abilities
        if snapshotValue["abilities"] != nil {
            let abilities = snapshotValue["abilities"] as! [[String: [String: Any]]]
            let itemAbilities = createAbilities(with: abilities, inContext: moc)
            item.abilities = NSOrderedSet(array: itemAbilities)
            
            // set the additional info if applicable
            if snapshotValue["additional_info"] != nil {
                var itemInfo = [ArrayValue]()
                for info in snapshotValue["additional_info"] as! [String] {
                    let arrayValue = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
                    arrayValue.value = info
                    itemInfo.append(arrayValue)
                }
                item.additionalInfo = NSSet(array: itemInfo)
            }
        }
        
        // set the details
        if snapshotValue["details"] != nil {
            var itemDetails = [ItemDetail]()
            for item in snapshotValue["details"] as! [String: [String]] {
                // create an item detail
                let itemDetail = NSEntityDescription.insertNewObject(forEntityName: "ItemDetail", into: moc) as! ItemDetail
                
                // get the key
                itemDetail.name = item.key
                
                // the dictionary holds an array of string
                var detailValues = [ArrayValue]()
                for detail in item.value {
                    let detailValue = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
                    detailValue.value = detail
                    detailValues.append(detailValue)
                }
                itemDetail.value = NSOrderedSet(array: detailValues)
                
                // append new item detail
                itemDetails.append(itemDetail)
            }
            item.details = NSSet(array: itemDetails)
        }
    }
    
    //The function that is meant to pull the entire database (for first download)
    static func importAll(toMOC moc: NSManagedObjectContext) {
        // create a dispatch group so we know when we're done
        let downloadGroup = DispatchGroup()
        
        // create a firebase reference
        let ref = [
            "heroes": FIRDatabase.database().reference(withPath: "hero"),
            "items": FIRDatabase.database().reference(withPath: "item")
        ]
        
        // enter group the the heroes
        downloadGroup.enter()
        ref["heroes"]?.observe(.value, with: {snapshots in
            for itter in snapshots.children {
                // create a snapshot
                let snapshot = itter as! FIRDataSnapshot
                self.insertHero(from: snapshot, inContext: moc)
            }
            
            // exit group we're done
            downloadGroup.leave()
        })
        
        // entre group for the items
        downloadGroup.enter()
        ref["items"]?.observe(.value, with: {snapshots in
            for itter in snapshots.children {
                // create snapshot
                let snapshot = itter as! FIRDataSnapshot
                insertItem(from: snapshot, inContext: moc)
            }
            
            downloadGroup.leave()
        })
        
        
        // when we're done downloading everything, let's save the NSManagedObjectContext
        downloadGroup.notify(queue: .main) {
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch {
                    print("Error saving moc after Firebase download: \(error.localizedDescription)")
                }
            }
        }
        
    }
}




















































