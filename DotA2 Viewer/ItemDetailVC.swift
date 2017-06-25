//
//  ItemDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class ItemDetailVC: UIViewController {
   
    public var item: Item? {
        didSet {
            if view != nil {
                updateView()
            }
        }
    }
    
    private func updateView() {
//        guard let hero = hero else {
//            return
//        }
//        self.title = hero.name
//        
//        heroStretchHeaderView.imageView.image = UIImage(named: hero.imageName)
//        ablilityVCV.abilities = hero.abilities?.array as? [Ability]
//        basicTVC.hero = hero
//        miscTVC.hero = hero
//        talentTVC.talents = hero.talents.allObjects as? [Talent]
//        
//        swapChildViewController(to: basicTVC)
        
    }
}











































