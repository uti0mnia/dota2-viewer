//
//  HeroDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-03.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroDetailVC: DetailVC {
    // MARK - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var heroView: HeroView!
    
    // MARK - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    
    /* This function sets up the data to be displayed */
    fileprivate func setup() {
        // make sure we have a hero to display
        guard let hero = object as? Hero else {
            return
        }
        
        heroView.imageView.image = hero.getImage()
        heroView.attackTypeLabel.text = (hero.miscStats?.projectileSpeed ?? "" == "Instant") ? "Melee" : "Ranged"
        heroView.rolesLabel.text = (hero.roles!.allObjects as! [String]).joined(separator: ", ")
        heroView.levelLabel.text = "Level 1"
        let attributes = hero.attribute?.allObjects as! [Attribute]
        let views = [heroView.attribute1View, heroView.attribute2View, heroView.attribute3View]
        for i in 0..<attributes.count { // set up the attributes
            views[i]?.imageView.image = attributes[i].image
            views[i]?.incrementLabel.text = "\(attributes[i].increment!)"
            views[i]?.currentValue.text = String(format: "%.0f", attributes[i].base!.doubleValue + attributes[i].increment!.doubleValue)
        }
        
        
        
        
    }

}
