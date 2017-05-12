//
//  HeroDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-03.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroDetailVC: DADetailVC {
    
    var hero: Hero!
    
    // MARK - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make sure we have an item
        hero = object as? Hero
        if (hero == nil) { return }
        
    }
}
































