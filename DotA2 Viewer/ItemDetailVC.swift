//
//  ItemDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class ItemDetailVC: DADetailVC {
    // MARK - Properties
    fileprivate var item: Item!
    
    // MARK - Methods
    override func viewDidLoad() {
        // make sure we have an item
        item = object as? Item
        if (item == nil) { return }
        
        // Configure the VC
        super.viewDidLoad()
    }
}











































