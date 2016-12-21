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
    fileprivate lazy var itemSV: ItemStackView = {[unowned self] in
        let sv = ItemStackView(abilitiesCount: self.model.abilities.count, withRecipe: !self.model.isSingularItem)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    fileprivate var model: ItemDetailModel!

    // MARK - Methods
    override func viewDidLoad() {
        // make sure we have an item
        guard let itemObj = object as? Item else {
            return
        }
        item = itemObj
        model = ItemDetailModel(item: item)
        
        // Configure the VC
        super.viewDidLoad()
        insertAbilities(model.abilities, into: itemSV.abilitiesSV)
        recipeSetup()
    }
    
    override internal func addSubviews() {
        super.addSubviews()
        
        // item stack view
        scrollView.addSubview(itemSV)
        var constraints = createConstraints(withVisual: "H:|[stackView(==scrollView)]|", withViews: ["stackView": itemSV, "scrollView": scrollView], options: .alignAllCenterX)
        constraints += createConstraints(withVisual: "V:|[stackView]|", withViews: ["stackView": itemSV], options: .alignAllCenterX)
        scrollView.addConstraints(constraints)
    }

    /* does the setup from the model to the views */
    override internal func setup() {
        super.setup()
        
        // expandable text SV
        itemSV.additionalInfoSV.textLabel.text = model.additionalInfoPretty
        itemSV.detailsSV.textLabel.attributedText = model.detailsString
        itemSV.loreSV.textLabel.text = model.lore
        
        // main view
        itemSV.mainSV.availabilityLabel.attributedText = model.availabilityPretty
        itemSV.mainSV.costLabel.icon = UIImage(named: "coins.png")
        itemSV.mainSV.costLabel.text = model.cost
        itemSV.mainSV.itemImageView.image = model.image
        itemSV.mainSV.typeImageView.image = model.typeImg
        itemSV.mainSV.typeLabel.text = model.type
    }
    
    /* Sets up the recipe */
    fileprivate func recipeSetup() {
        // make sure we actually need to make one
        guard !model.isSingularItem else {
            return
        }
        DispatchQueue.main.async {
            // create the Recipe Sub StackView
            let image = self.model.image
            let buildsFrom = self.model.buildsFrom?.map({ $0.getImage() })
            let buildsInto = self.model.buildsInto?.map({ $0.getImage() })
            let needsRecipe = self.model.needsRecipe
            let subView = RecipeSubStackView(image: image, buildsFrom: buildsFrom, buildsInto: buildsInto, needsRecipe: needsRecipe)
            
            // enable tapping button to move to new item
            for i in 0..<(subView.topSV?.arrangedSubviews.count ?? 0) {
                if let btn = subView.topSV?.arrangedSubviews[i] as? RecipeButton {
                    if let item = self.model.buildsInto?[i] {
                        btn.item = item
                        btn.addTarget(self, action: #selector(ItemDetailVC.recipeButtonTapped(_:)), for: .touchUpInside)
                    }
                }
            }
            for i in 0..<(subView.bottomSV?.arrangedSubviews.count ?? 0) {
                if let btn = subView.bottomSV?.arrangedSubviews[i] as? RecipeButton {
                    if let item = self.model.buildsFrom?[i] {
                        btn.item = item
                        btn.addTarget(self, action: #selector(ItemDetailVC.recipeButtonTapped(_:)), for: .touchUpInside)
                    }
                }
            }
            
            // add it to the RecipeStackView
            self.itemSV.recipeSV?.setSubview(subView)
        }
    }
    
    /* Is called when recipe button is tapped */
    @objc fileprivate func recipeButtonTapped(_ sender: RecipeButton) {
        if let item = sender.item {
            moveTo(item: item)
        }
    }
    
    /* Handles the move to a new item */
    fileprivate func moveTo(item: Item) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailVC
        vc.object = item
        self.navigationController?.pushViewController(vc, animated: true)
    }

}











































