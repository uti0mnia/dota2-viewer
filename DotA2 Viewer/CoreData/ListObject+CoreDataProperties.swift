//
//  ListObject+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-11-10.
//
//

import Foundation
import CoreData


extension ListObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListObject> {
        return NSFetchRequest<ListObject>(entityName: "ListObject");
    }

    @NSManaged public var name: String!

}
