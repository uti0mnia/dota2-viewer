//
//  ItemDetailVC.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-22.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

// delegate method for picking ListObjects (usually item) to display

class ItemDetailVC: ObjectDetailVC {
    
    /* Outlets */
    /* Properties */
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fullStackView: UIStackView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var recipeStack: UIStackView!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var cooldownLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var loreLabel: UILabel!
    
    // properties

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        refineView()
    }
    
    fileprivate func setView() {
        guard object is Item else { return }
        
        // get the object as an item
        let item = object as! Item
        // set up the view
        // the main image
        self.itemImageView.image = item.objectImage()
        
        // the recipes
        if (item.recipe != nil) {
            // create an array of Recipe to itterate over
            let recipes = item.recipe!.allObjects as! [Recipe]
            for recipe in recipes {
                // create the recipe button
                let btn = RecipeButton(itemID: recipe.itemID!)
                btn.addTarget(self, action: #selector(recipeButtonPressed(sender:)), for: .touchUpInside)
                
                // add it to the stack view
                self.recipeStack.addArrangedSubview(btn)
            }
        }
        
        // set the info stack view
        self.costLabel.text = item.cost
        self.manaLabel.text = item.mana
        self.cooldownLabel.text = item.cooldown
        self.typeLabel.text = item.type
        self.typeImageView.image = item.getTypeImage()
        
        // set the details stack view
        self.abilityLabel.text = item.ability?.replacingOccurrences(of: "\\n", with: "\n")
        self.detailLabel.text = item.detail?.replacingOccurrences(of: "\\n", with: "\n")
        self.loreLabel.text = item.lore?.replacingOccurrences(of: "\\n", with: "\n")
    }
    
    @objc fileprivate func recipeButtonPressed(sender: RecipeButton) {
        guard sender.item != nil else { return }
        del?.didSelectObject(object: sender.item!)
    }
    
    fileprivate func refineView() {
        // meant to remove items from the view if they're empty
        if recipeStack.arrangedSubviews.count <= 1 { recipeStack.removeFromSuperview() }
        if manaLabel.text == nil || manaLabel.text == "" { manaLabel.removeFromSuperview() }
        if cooldownLabel.text == nil || cooldownLabel.text == "" { cooldownLabel.removeFromSuperview() }
        if abilityLabel.text == nil || abilityLabel.text == "" { cooldownLabel.removeFromSuperview() }
        if detailLabel.text == nil || detailLabel.text == "" { detailLabel.removeFromSuperview() }
        if loreLabel.text == nil || loreLabel.text == "" { loreLabel.removeFromSuperview() }
        
        // set properties
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
    }
}






































