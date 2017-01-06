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
import SwiftyJSON


struct Import {
    
    /* This function is meant to create abilities from the abilities in the firebase db */
    static private func createAbilities(with abilities: [JSON], inContext moc: NSManagedObjectContext) -> [Ability] {
        var heroAbilities = [Ability]()
        for obj in abilities {
            // get the name of the ability
            let name = obj.dictionaryValue.keys.first!
            
            // create a NSManagedObject
            let ability = NSEntityDescription.insertNewObject(forEntityName: "Ability", into: moc) as! Ability
            ability.name = name
            ability.cooldown = obj[name]["Cooldown"].string
            ability.mana = obj[name]["Mana"].string
            ability.summary = obj[name]["description"].string
            
            // get the specials
            if obj[name]["ability_special"].exists() {
                var abilitySpecials = [ArrayValue]()
                for special in obj[name]["ability_special"].arrayValue {
                    let abilitySpecial = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
                    abilitySpecial.value = special.string
                    abilitySpecials.append(abilitySpecial)
                }
                ability.abilitySpecial = NSSet(array: abilitySpecials)
            }
            
            // get the special details
            if obj[name]["special_details"].exists() {
                var specialDetails = [ArrayValue]()
                for detail in obj[name]["special_details"].arrayValue {
                    let specialDetail = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
                    specialDetail.value = detail.string
                    specialDetails.append(specialDetail)
                }
                ability.specialDetails = NSSet(array: specialDetails)
            }
            
            // get the data for the ability
            var abilityDatas = [ArrayValue]()
            for data in obj[name]["data"].arrayValue {
                let abilityData = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
                abilityData.value = data.string
                abilityDatas.append(abilityData)
            }
            ability.data = NSSet(array: abilityDatas)
            
            // if the ability has modifiers, add them
            if obj[name]["modifiers"].exists() {
                var abilityModifiers = [ArrayValue]()
                for modifier in obj[name]["modifiers"].arrayValue {
                    let abilityModifier = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
                    abilityModifier.value = modifier.string
                    abilityModifiers.append(abilityModifier)
                }
                ability.modifiers = NSSet(array: abilityModifiers)
            }
            
            // if the ability has notes, add them
            if obj[name]["notes"].exists() {
                let notes = createNote(from: obj[name]["notes"].arrayValue, inContext: moc, notes: [Note]())
                ability.notes = NSOrderedSet(array: notes)
            }
            
            // get the ability types
            var types = [AbilityType]()
            // iterate through each dictionary values
            for type in obj[name]["types"].dictionaryValue {
                // create the ability type (has type and [ArrayValue]()
                let abilityType = NSEntityDescription.insertNewObject(forEntityName: "AbilityType", into: moc) as! AbilityType
                var typeValues = [ArrayValue]()
                // get each values for that type
                for value in type.value.arrayValue {
                    let arrayValue = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
                    arrayValue.value = value.string
                    typeValues.append(arrayValue)
                }
                abilityType.type = type.key
                abilityType.value = NSSet(array: typeValues)
                types.append(abilityType)
            }
            ability.type = NSSet(array: types)
            
            heroAbilities.append(ability)
        }
        
        return heroAbilities
    }
    
    /* This function is meant to create notes/subnotes from the notes in the firebase db */
    static private func createNote(from array: [JSON], inContext moc: NSManagedObjectContext, notes: [Note]) -> [Note] {
        // base case
        if array.count == 0 {
            return notes
        }
        
        // array case
        if let subArray = array[0].array {
            let subNotes = createNote(from: subArray, inContext: moc, notes: [Note]())
            notes.last?.subNotes = NSOrderedSet(array: subNotes)
            let newArray = Array<JSON>(array[1..<array.count])
            return createNote(from: newArray, inContext: moc, notes: notes)
        }
        
        // string case
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: moc) as! Note
        note.string = array[0].string
        let newNotes = notes + [note]
        let newArray = Array<JSON>(array[1..<array.count])
        return createNote(from: newArray, inContext: moc, notes: newNotes)
        
    }
    
    /* This function is meant to insert a Hero object into the object context */
    static private func insertHero(from snapshot: (String, JSON), inContext moc: NSManagedObjectContext) {
        // create hero entity
        let hero = NSEntityDescription.insertNewObject(forEntityName: "Hero", into: moc) as! Hero
        // get the snapshot value (JSON)
        let name = snapshot.0
        let snapshotValue = snapshot.1
        hero.name = name
        
        // set values
        hero.summary = snapshotValue["description"].string
        hero.lore = snapshotValue["lore"].string
        
        // get the roles
        var roles = [ArrayValue]()
        for val in snapshotValue["roles"].arrayValue {
            let role = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
            role.value = val.string
            roles.append(role)
        }
        hero.roles = NSSet(array: roles)
        
        // get misc stats
        let miscStat = NSEntityDescription.insertNewObject(forEntityName: "MiscStat", into: moc) as! MiscStat
        miscStat.attackAnimation = snapshotValue["misc_stats"]["Attack Animation"].string
        miscStat.attackRange = NSDecimalNumber(string: snapshotValue["misc_stats"]["Attack Range"].string)
        miscStat.attackTime = NSDecimalNumber(string: snapshotValue["misc_stats"]["Base Attack Time"].string)
        miscStat.collisionSize = NSDecimalNumber(string: snapshotValue["misc_stats"]["Collision Size"].string)
        miscStat.magicResistance = NSDecimalNumber(string: snapshotValue["misc_stats"]["Magic resistance"].string)
        miscStat.movementSpeed = NSDecimalNumber(string: snapshotValue["misc_stats"]["Movement Speed"].string)
        miscStat.projectileSpeed = snapshotValue["misc_stats"]["Projectile Speed"].string
        miscStat.turnRate = NSDecimalNumber(string: snapshotValue["misc_stats"]["Turn Rate"].string)
        miscStat.visionRange = snapshotValue["misc_stats"]["Vision Range"].string
        hero.miscStats = miscStat
        
        // get base stats
        let baseStat = NSEntityDescription.insertNewObject(forEntityName: "BaseStat", into: moc) as! BaseStat
        baseStat.armor = NSDecimalNumber(string: snapshotValue["base_stats"]["armor"].string)
        baseStat.attackPerS = NSDecimalNumber(string: snapshotValue["base_stats"]["attack_s"].string)
        let damage = NSEntityDescription.insertNewObject(forEntityName: "Damage", into: moc) as! Damage
        damage.min = NSDecimalNumber(string: snapshotValue["base_stats"]["damage"]["min"].string)
        damage.max = NSDecimalNumber(string: snapshotValue["base_stats"]["damage"]["max"].string)
        baseStat.damage = damage
        baseStat.hp = NSDecimalNumber(string: snapshotValue["base_stats"]["hp"].string)
        baseStat.hpRegen = NSDecimalNumber(string: snapshotValue["base_stats"]["hp_regen"].string)
        baseStat.mana = NSDecimalNumber(string: snapshotValue["base_stats"]["mana"].string)
        baseStat.manaRegen = NSDecimalNumber(string: snapshotValue["base_stats"]["mana_regen"].string)
        baseStat.spellDamage = NSDecimalNumber(string: snapshotValue["base_stats"]["spell_damage"].string)
        hero.baseStats = baseStat
        
        // get attributes
        let attributes = ["Agility", "Intelligence", "Strength"]
        var heroAttributes = [Attribute]()
        for attr in attributes {
            let val = snapshotValue["attributes"][attr]
            let attribute = NSEntityDescription.insertNewObject(forEntityName: "Attribute", into: moc) as! Attribute
            attribute.name = attr
            attribute.base = NSDecimalNumber(string: val["base"].string)
            attribute.increment = NSDecimalNumber(string: val["increment"].string)
            attribute.isPrimary = NSDecimalNumber(value: val["primary"].int!)
            heroAttributes.append(attribute)
        }
        hero.attribute = NSSet(array: heroAttributes)
        
        // get talent tree
        var talents = [Talent]()
        for obj in snapshotValue["talents"].arrayValue {
            let talent = NSEntityDescription.insertNewObject(forEntityName: "Talent", into: moc) as! Talent
            talent.level = NSDecimalNumber(string: obj["level"].string)
            talent.left = obj["left"].string
            talent.right = obj["right"].string
            talents.append(talent)
        }
        hero.talents = NSSet(array: talents)
        
        // get talent notes (if any)
        if snapshotValue["talent_notes"].exists() {
            var talentNotes = [ArrayValue]()
            for obj in snapshotValue["talent_notes"].arrayValue {
                let talentNote = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
                talentNote.value = obj.string
                talentNotes.append(talentNote)
            }
            hero.talentNotes = NSSet(array: talentNotes)
        }
        
        // get abilities
        let abilities = snapshotValue["abilities"].arrayValue
        let heroAbilities = createAbilities(with: abilities, inContext: moc)
        hero.abilities = NSOrderedSet(array: heroAbilities)
    }
    
    /* This function is meant to insert a Hero object into the object context */
    static private func insertItem(from snapshot: (String, JSON), inContext moc: NSManagedObjectContext) {
        // insert new item entity
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: moc) as! Item
        
        // get the snapshot value (JSON)
        let name = snapshot.0
        let snapshotValue = snapshot.1
        item.name = name
        
        // set simple values
        item.cost = snapshotValue["cost"].string
        item.lore = snapshotValue["lore"].string
        item.type = snapshotValue["type"].string
        
        // set the abilities
        if snapshotValue["abilities"] != nil {
            let abilities = snapshotValue["abilities"].arrayValue
            let itemAbilities = createAbilities(with: abilities, inContext: moc)
            item.abilities = NSOrderedSet(array: itemAbilities)
        }
        
        // set the additional info if applicable
        if snapshotValue["additional_info"] != nil {
            var itemInfo = [ArrayValue]()
            for info in snapshotValue["additional_info"].arrayValue {
                let arrayValue = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
                arrayValue.value = info.string
                itemInfo.append(arrayValue)
            }
            item.additionalInfo = NSSet(array: itemInfo)
        }
        
        // set the availability
        if snapshotValue["availability"].exists() {
            var values = [ArrayValue]()
            for item in snapshotValue["availability"].arrayValue {
                let value = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
                value.value = item.string
                values.append(value)
            }
            item.availability = NSSet(array: values)
        }
        
        // set the details
        if snapshotValue["details"].exists() {
            // create array to hold details
            var itemDetails = [ItemDetail]()
            var buildsFrom: [ArrayValue]?
            var buildsInto: [ArrayValue]?
            
            // itterate through each detail
            for (key, value) in snapshotValue["details"].dictionaryValue {
                let name = key
                
                // check if it builds from items
                if name == "builds_from" {
                    // init the array if it's nil
                    if buildsFrom == nil { buildsFrom = [ArrayValue]() }
                    
                    // iterate through each value of the dict to make the array
                    for i in value.arrayValue {
                        let val = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
                        val.value = i.stringValue
                        buildsFrom?.append(val)
                    }
                }
                    
                // check if it build into items
                else if name == "builds_into" {
                    // init the array if it's nil
                    if buildsInto == nil { buildsInto = [ArrayValue]() }
                    
                    // iterate through each value of the dict to make the array
                    for i in value.arrayValue {
                        let val = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
                        val.value = i.stringValue
                        buildsInto?.append(val)
                    }
                }
                
                // it's a regulary detail
                else {
                    // create an item detail
                    let itemDetail = NSEntityDescription.insertNewObject(forEntityName: "ItemDetail", into: moc) as! ItemDetail
                    
                    // get the "name"
                    itemDetail.name = name
                    
                    // the dictionary holds an array of string
                    var detailValues = [ArrayValue]()
                    for detail in value.arrayValue {
                        let detailValue = NSEntityDescription.insertNewObject(forEntityName: "ArrayValue", into: moc) as! ArrayValue
                        detailValue.value = detail.string
                        detailValues.append(detailValue)
                    }
                    itemDetail.value = NSOrderedSet(array: detailValues)
                    
                    // append new item detail
                    itemDetails.append(itemDetail)
                }
            }
            
            // set the item details
            item.details = NSSet(array: itemDetails)
            if let into = buildsInto {
                item.buildsInto = NSSet(array: into)
            }
            if let from = buildsFrom {
                item.buildsFrom = NSSet(array: from)
            }
            
        }
    }
    
    struct FirebaseImport {
        /* The function that is meant to pull the entire database (DO NOT USE) */
        static func importAll(toMOC moc: NSManagedObjectContext) {
//            // create a dispatch group so we know when we're done
//            let downloadGroup = DispatchGroup()
//            
//            // create a firebase reference
//            let ref = [
//                "heroes": FIRDatabase.database().reference(withPath: "hero"),
//                "items": FIRDatabase.database().reference(withPath: "item")
//            ]
//            
//            // enter group the the heroes
//            downloadGroup.enter()
//            ref["heroes"]?.observe(.value, with: {snapshots in
//                for itter in snapshots.children {
//                    // create a snapshot
//                    let snapshot = itter as! FIRDataSnapshot
//                    Import.insertHero(from: snapshot, inContext: moc)
//                }
//                
//                // exit group we're done
//                downloadGroup.leave()
//            })
//            
//            // entre group for the items
//            downloadGroup.enter()
//            ref["items"]?.observe(.value, with: {snapshots in
//                for itter in snapshots.children {
//                    // create snapshot
//                    let snapshot = itter as! FIRDataSnapshot
//                    Import.insertItem(from: snapshot, inContext: moc)
//                }
//                
//                downloadGroup.leave()
//            })
//            
//            
//            // when we're done downloading everything, let's save the NSManagedObjectContext
//            downloadGroup.notify(queue: .main) {
//                if moc.hasChanges {
//                    do {
//                        try moc.save()
//                    } catch {
//                        print("Error saving moc after Firebase download: \(error.localizedDescription)")
//                    }
//                }
//            }
//            
        }
    }
    
    struct JSONImport {
        static func initialImport(inMOC moc: NSManagedObjectContext) {
            do {
                // get the path to the JSON file
                if let path = Bundle.main.path(forResource: "dota2", ofType: "json") {
                    // get the data form the file
                    let data = try NSData(contentsOfFile: path) as Data
                    let json = JSON(data: data)
                    
                    // import each hero
                    for hero in json["hero"].dictionaryValue {
                        Import.insertHero(from: hero, inContext: moc)
                    }
                    
                    // import each item
                    for item in json["item"].dictionaryValue {
                        Import.insertItem(from: item, inContext: moc)
                    }
                    
                } else {
                    print("No path...")
                }
            } catch {
                print("Error reading file dota2.json: \(error.localizedDescription)")
            }
            
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch {
                    print("Error saving moc: \(error.localizedDescription)")
                }
            }
        }
    }
}


















































