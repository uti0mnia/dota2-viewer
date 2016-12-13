//
//  ItemDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class ItemDetailVC: UIViewController {
    // MARK - Properties
    var item: Item!
    fileprivate var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    fileprivate lazy var itemSV: ItemStackView = {[unowned self] in
        let sv = ItemStackView(abilitiesCount: self.model.abilities.count, withRecipe: !self.model.isSingularItem)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    fileprivate lazy var titleLabel: DAMainLabel = {[unowned self] in
        let lbl = DAMainLabel(style: .large)
        lbl.text = self.item.name!
        lbl.sizeToFit()
        return lbl
    }()
    fileprivate var model: ItemDetailModel!

    // MARK - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        guard item != nil else { return }
        configure()
    }
    
    /* configures the VC */
    private func configure() {
        model = ItemDetailModel(item: item)
        configureViews()
        abilitySetup()
        recipeSetup()
        setup()
    }
    
    /* configures the views to the view controller */
    fileprivate func configureViews() {
        // colours
        self.view.backgroundColor = UIColor.flatBlack()
        
        // scrollview
        self.view.addSubview(scrollView)
        var constraints = [NSLayoutConstraint]()
        constraints += createConstraints(withVisual: "H:|[scrollView]|", withViews: ["scrollView": scrollView], options: .alignAllCenterX)
        constraints += createConstraints(withVisual: "V:|[scrollView]|", withViews: ["scrollView": scrollView], options: .alignAllCenterX)
        self.view.addConstraints(constraints)
        
        // item stack view
        scrollView.addSubview(itemSV)
        constraints.removeAll()
        constraints += createConstraints(withVisual: "H:|[stackView(==scrollView)]|", withViews: ["stackView": itemSV, "scrollView": scrollView], options: .alignAllCenterX)
        constraints += createConstraints(withVisual: "V:|[stackView]|", withViews: ["stackView": itemSV], options: .alignAllCenterX)
        scrollView.addConstraints(constraints)
    }

    /* does the setup from the model to the vies */
    fileprivate func setup() {
        // navigation bar
        self.navigationItem.titleView = titleLabel
        
        // expandable text SV
        itemSV.additionalInfoSV.textLabel.text = model.additionalInfoPretty
        itemSV.detailsSV.textLabel.attributedText = model.detailsString
        itemSV.loreSV.textLabel.text = model.lore
        
        // main view
        itemSV.mainSV.availabilityLabel.text = model.availability.joined(separator: ", ")
        itemSV.mainSV.costLabel.text = model.cost
        itemSV.mainSV.itemImageView.image = model.image
        itemSV.mainSV.typeImageView.image = model.typeImg
        itemSV.mainSV.typeLabel.text = model.type
    }
    
    /* Sets up the ablities */
    fileprivate func abilitySetup() {
        // we want to load the abilities asynchronously
        for i in 0..<model.abilities.count {
            DispatchQueue.main.async {
                // create the ability model
                let abilityModel = self.model.abilities[i]
                // create the subview for the AbiltyStackView
                let subView = AbilitySubStackView()
                subView.abilityImageView.image = abilityModel.image
                subView.cooldownLabel.text = abilityModel.cooldown
                subView.dataLabel.attributedText = abilityModel.dataPretty
                subView.manaLabel.text = abilityModel.mana
                subView.modifiersLabel.text = abilityModel.modifiers.joined(separator: "\n")
                subView.notesSV.textLabel.text = abilityModel.notesPretty
                subView.summaryLabel.text = abilityModel.summary
                subView.typesLabel.attributedText = abilityModel.typesPrettyPrint
                
                // set the AbilitySV subview
                self.itemSV.abilitiesSV?.subStackViews[i].nameLabel.text = abilityModel.name
                self.itemSV.abilitiesSV?.subStackViews[i].specialsLabel.attributedText = abilityModel.specialsPretty
                self.itemSV.abilitiesSV?.subStackViews[i].setSubview(subView)
            }
        }
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
        vc.item = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func createConstraints(withVisual str: String, withViews views: [String: Any], options: NSLayoutFormatOptions = []) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: str, options: options, metrics: nil, views: views)
    }

}











































