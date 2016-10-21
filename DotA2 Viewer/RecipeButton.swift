//
//  RecipeButton.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-21.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import CoreData

class RecipeButton: UIButton {

    var item: Item?
    
    // initializer
    required init(frame: CGRect, item: Item?) {
        super.init(frame: frame)
        self.item = item
        
        // set the button
        configureButton()
    }
    
    convenience init(item: Item?) {
        self.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50), item: item)
    }
    
    convenience init(itemID: String) {
        guard itemID != "recipe" else {
            self.init(item: nil)
            
            return
        }
        // create the fetch request
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        let predicate = NSPredicate(format: "id == %@", itemID)
        fetchRequest.predicate = predicate
        
        // create the item that we are fetching (might return nothing)
        var item: Item?
        do {
            let moc = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
            let results = try moc.fetch(fetchRequest)
            item = results.first
        } catch {
            print("Error fetching Items: \(error.localizedDescription). At \(#function)")
        }
        
        // check if the fetch succeeded
        if item != nil {
            self.init(item: item!)
        } else {
            fatalError("itemID \"\(itemID)\" doesn't exist... fix this now.")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // methods
    private func configureButton() {
        var img: UIImage!
        if item != nil {
            img = item!.getImage()
        } else {
            img = UIImage(named: "recipe.png") // recipe
            self.isEnabled = false // turn off button
        }
        self.setImage(img, for: .normal)
        
    }

}


















