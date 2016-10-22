//
//  File.swift
//  DotA2 Pro
//
//  Created by Casey McLewin on 2016-05-27.
//  Copyright © 2016 Casey McLewin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CSVImporter {
    var moc: NSManagedObjectContext!
    
    required init(managedObjectContext moc: NSManagedObjectContext) {
        self.moc = moc //initialize context
    }
    
    private enum ImportType {
        case hero, item
    }
    func importCSV() {
        //parse the CSVs
        parseCSV("hero_final", type: .hero)
        parseCSV("items_final", type: .item)
        
        //save the context
        do {
            try moc.save()
        } catch {
            print("MOC Error: \(error.localizedDescription)")
            fatalError("Unable to save MOC at line \(#line) of \(#function)")
        }
    }
    
    private func parseCSV(_ name: String, type: ImportType) {
        
        //get the path to the CSV file
        let path = Bundle.main.path(forResource: name, ofType: "csv")
        guard path != nil else {
            print("\(name) not found")
            return
        }
        
        //create a StreamReader to iterate through each line
        if let aStreamReader = StreamReader(path: path!) {
            defer {
                aStreamReader.close()
            }
            switch type {
            case .hero:
                for line in aStreamReader {
                    let csv = CSwiftV(string: line)
                    saveHero(csv)
                }
            case .item:
                for line in aStreamReader {
                    let csv = CSwiftV(string: line)
                    saveItem(csv)
                }
            }
            
        }
    }
    
    private func saveHero(_ line: CSwiftV) {
        //create hero MO
        let hero = NSEntityDescription.insertNewObject(forEntityName: "Hero", into: moc) as! Hero
        var data = line.headers.makeIterator()
        
        //load the data
        hero.name = data.next()
        hero.attackType = data.next()
        hero.role = data.next()
        hero.bio = data.next()
        
        //MARK: Primary Stats
        
        let pStat = NSEntityDescription.insertNewObject(forEntityName: "PrimaryStat",
                                                                        into: moc) as! PrimaryStat
        pStat.intelligence = data.next()
        pStat.agility = data.next()
        pStat.strength = data.next()
        pStat.damage = data.next()
        pStat.speed = data.next()
        pStat.armor = data.next()
        hero.primaryStat = pStat //link the hero with its primary stats
        
        //MARK: Stats
        
        let lvls = Int(data.next()!)
        guard lvls != nil else {
            fatalError("Couldn't convert to int for # of levels for \(line) ")
        }
        var stats = [Stat]()
        for _ in 0..<lvls! {
            //create a new stat
            let stat = NSEntityDescription.insertNewObject(forEntityName: "Stat",
                                                                           into: moc) as! Stat
            stat.level = data.next()
            stat.hp = data.next()
            stat.mana = data.next()
            stat.damage = data.next()
            stat.armor = data.next()
            stat.sight = data.next()
            stat.attackRange = data.next()
            stat.missleSpeed = data.next()
            stats.append(stat)
        }
        hero.stat = NSSet(array: stats) //add the stats
        
        //MARK: Abilities
        
        let abilityNum = Int(data.next()!)
        guard abilityNum != nil else {
            fatalError("Couldn't convert to int for # of abilities for \(line)")
        }
        var abilities = [Ability]()
        for _ in 0..<abilityNum! {
            let ability = NSEntityDescription.insertNewObject(forEntityName: "Ability",
                                                                              into: moc) as! Ability
            ability.name = data.next()
            ability.summary = data.next()
            ability.lore = data.next()
            ability.mana = data.next()
            ability.cooldown = data.next()
            ability.data = data.next()
            _ = data.next() //this is the image URL
            ability.videoURL = data.next()
            abilities.append(ability)
        }
        hero.ability = NSSet(array: abilities)
        
        
        
    }
    
    private func saveItem(_ line: CSwiftV) {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item",
                                                                       into: moc) as! Item
        var data = line.headers.makeIterator()
        item.name = data.next()
        item.type = data.next()
        item.cost = data.next()
        item.cooldown = data.next()
        item.mana = data.next()
        item.lore = data.next()
        item.ability = data.next()
        item.detail = data.next()
        item.id = data.next()
        
        //MARK: Recipe
        let rNum = Int(data.next()!) //number of recipe items in item
        guard rNum != nil else {
            fatalError("Couldn't convert to int for recipe for \(line)")
        }
        var recipes: [Recipe]?
        for _ in 0..<rNum! {
            if recipes == nil {
                recipes = [Recipe]()
            }
            let recipe = NSEntityDescription.insertNewObject(forEntityName: "Recipe",
                                                                             into: moc) as! Recipe
            recipe.itemID = data.next()
            recipe.item = item
            recipes?.append(recipe)
        }
        if recipes != nil {
            item.recipe = NSSet(array: recipes!)
        }
        
    }
}

class StreamReader  {
    
    let encoding : String.Encoding
    let chunkSize : Int
    
    var fileHandle : FileHandle!
    let buffer : NSMutableData!
    let delimData : Data!
    var atEof : Bool = false
    
    init?(path: String, delimiter: String = "\n", encoding : String.Encoding = .utf8, chunkSize : Int = 4096) {
        self.chunkSize = chunkSize
        self.encoding = encoding
        
        if let fileHandle = FileHandle(forReadingAtPath: path),
            let delimData = delimiter.data(using: encoding),
            let buffer = NSMutableData(capacity: chunkSize)
        {
            self.fileHandle = fileHandle
            self.delimData = delimData
            self.buffer = buffer
        } else {
            self.fileHandle = nil
            self.delimData = nil
            self.buffer = nil
            return nil
        }
    }
    
    deinit {
        self.close()
    }
    
    /// Return next line, or nil on EOF.
    func nextLine() -> String? {
        precondition(fileHandle != nil, "Attempt to read from closed file")
        
        if atEof {
            return nil
        }
        
        // Read data chunks from file until a line delimiter is found:
        var range = buffer.range(of: delimData, options: [], in: NSMakeRange(0, buffer.length))
        while range.location == NSNotFound {
            let tmpData = fileHandle.readData(ofLength: chunkSize)
            if tmpData.count == 0 {
                // EOF or read error.
                atEof = true
                if buffer.length > 0 {
                    // Buffer contains last line in file (not terminated by delimiter).
                    let line = NSString(data: buffer as Data, encoding: String.Encoding.utf8.rawValue)
                    
                    buffer.length = 0
                    return line as String?
                }
                // No more lines.
                return nil
            }
            buffer.append(tmpData)
            range = buffer.range(of: delimData, options: [], in: NSMakeRange(0, buffer.length))
        }
        
        // Convert complete line (excluding the delimiter) to a string:
        let line = NSString(data: buffer.subdata(with: NSMakeRange(0, range.location)),
                            encoding: String.Encoding.utf8.rawValue)
        // Remove line (and the delimiter) from the buffer:
        buffer.replaceBytes(in: NSMakeRange(0, range.location + range.length), withBytes: nil, length: 0)
        
        return line as String?
    }
    
    /// Start reading from the beginning of file.
    func rewind() -> Void {
        fileHandle.seek(toFileOffset: 0)
        buffer.length = 0
        atEof = false
    }
    
    /// Close the underlying file. No reading must be done after calling this method.
    func close() -> Void {
        fileHandle?.closeFile()
        fileHandle = nil
    }
}

extension StreamReader : Sequence {
    func makeIterator() -> AnyIterator<String> {
        return AnyIterator {
            return self.nextLine()
        }
    }
}
