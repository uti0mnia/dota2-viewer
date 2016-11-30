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
    //The function that is meant to pull the entire database (for first download)
    static func importAll() {
        // create a firebase reference
        let ref = ["heroes": FIRDatabase.database().reference(withPath: "hero"),
                   "items": FIRDatabase.database().reference(withPath: "item")
        ]
        
//        ref["heroes"]?.observe(.value, with: {snapshot in
//            print(snapshot.value)
//        })
        ref["items"]?.observe(.value, with: {snapshot in
            print(snapshot.value)
        })
        
    }
}
