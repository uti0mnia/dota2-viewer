//
//  ListObject+CoreDataProperties.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData


extension ListObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListObject> {
        return NSFetchRequest<ListObject>(entityName: "ListObject");
    }

    @NSManaged public var name: String

}
