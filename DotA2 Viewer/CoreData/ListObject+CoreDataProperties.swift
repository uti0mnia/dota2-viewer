//
//  ListObject+CoreDataProperties.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-15.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation
import CoreData


extension ListObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListObject> {
        return NSFetchRequest<ListObject>(entityName: "ListObject");
    }

    @NSManaged public var name: String?
    @NSManaged public var image: NSData?

}
