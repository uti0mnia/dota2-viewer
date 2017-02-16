//
//  CoreModel.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreModel: NSObject, NSFetchedResultsControllerDelegate {
    // properties
    fileprivate var context: NSManagedObjectContext!
    var heroFRC: NSFetchedResultsController<ListObject> = {
        let fetchRequest = NSFetchRequest<ListObject>(entityName: "Hero")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        
        // init the frc
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
        managedObjectContext: self.context,
        sectionNameKeyPath: "firstLetter",
        cacheName: nil)
        frc.delegate = self
        return frc
    
    }()
    var itemFRC: NSFetchedResultsController<ListObject> = {
        let request = NSFetchRequest<ListObject>(entityName: "Item")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        // init the frc
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: self.context,
                                             sectionNameKeyPath: "firstLetter",
                                             cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
}
