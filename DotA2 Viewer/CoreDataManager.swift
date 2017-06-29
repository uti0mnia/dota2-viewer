//
//  CoreDataManager.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-27.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    public static let shared = CoreDataManager()
    
    private var moc = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    private init() {}
    
    
    public func fetchItem(withName name: String) -> Item? {
        let request = NSFetchRequest<Item>(entityName: "Item")
        let predicate = NSPredicate(format: "name == %@", name)
        request.predicate = predicate
        do {
            let items = try moc.fetch(request)
            return items.first
        } catch {
            print("Error fetching Item with name '\(name)': \(error.localizedDescription)")
            return nil
        }
    }
    
    
}
