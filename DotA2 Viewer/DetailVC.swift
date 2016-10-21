//
//  HeroDetailVC.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController {
    
    var object: ListObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard object != nil else { return }
        
        configureView() // confire the view to be hero or items
    }
    
    private func configureView() {
        if object is Item {
            setViewAsItemView()
        }
        if object is Hero {
            
        }
    }
    
    private func setViewAsItemView() {
        // make sure the object is an Item
        guard object is Item else { return }
        
        let item = object as! Item
        // create the view
        let view = ItemDetailView(frame: self.view.frame)
        
        // set up the view
        // the main image
        view.itemImageView.image = item.getImage()
        
        // the recipes
        if (item.recipe != nil) {
            // create an array of Recipe to itterate over
            let recipes = item.recipe!.allObjects as! [Recipe]
            for recipe in recipes {
                // create the recipe button
                let btn = RecipeButton(itemID: recipe.itemID!)
                btn.addTarget(self, action: #selector(recipeButtonPressed(sender:)), for: .touchUpInside)
                
                // add it to the stack view
                view.recipeStack.addArrangedSubview(btn)
            }
        }
        
        // set the info stack view
        view.costLabel.text = item.cost
        view.manaLabel.text = item.mana
        view.cooldownLabel.text = item.cooldown
        view.typeLabel.text = item.type
        view.typeImageView.image = item.getTypeImage()
        
        // set the details stack view
        view.abilityLabel.text = item.ability
        view.detailLabel.text = item.detail
        view.loreLabel.text = item.lore
        
        // refine the view to remove unecessary views
        view.refineView()
        
    }
    
    @objc fileprivate func recipeButtonPressed(sender: RecipeButton) {
        guard sender.item != nil else { return }
        swapView(toObject: sender.item!)
    }
    
    fileprivate func swapView(toObject object: ListObject) {
        self.object = object
        configureView()
    }
    
    
}


































