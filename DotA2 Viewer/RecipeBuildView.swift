//
//  ItemBuildStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-25.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class RecipeBuildView: UIStackView {
    
    public weak var delegate: RecipeBuildViewDelegate?
    
    public var itemNames: [String]? {
        didSet {
            recipeParts.forEach({ $0.removeFromSuperview() })
            topLabel.isHidden = true
            
            guard var itemNames = itemNames, itemNames.count > 0 else {
                return
            }
            
            if let index = itemNames.index(of: "Recipe") {
                let recipe = itemNames.remove(at: index)
                itemNames.append(recipe)
            }
            
            topLabel.isHidden = false
            insertArrangedSubview(topLabel, at: 0)
            
            for index in 0..<itemNames.count {
                let name = itemNames[index]
                
                if index >= recipeParts.count {
                    recipeParts.append(createRecipePart())
                }
                
                recipeParts[index].itemName = name
                recipeStackView.addArrangedSubview(recipeParts[index])
            }
        }
    }
    
    public var topLabelText: String? {
        didSet {
            topLabel.text = topLabelText
        }
    }
    
    private var recipeParts = [RecipePart]()
    private var recipeStackView = UIStackView()
    private var topLabel = DALabel(style: .subtitle)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        axis = .vertical
        distribution = .fillProportionally
        spacing = Layout.defaultPadding
        
        recipeStackView.distribution = .fillEqually
        recipeStackView.spacing = Layout.defaultPadding
        
        u0_addArrangedSubviews(views: [topLabel, recipeStackView])
    }
    
    private func createRecipePart() -> RecipePart {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnRecipePart(_:)))
        
        let recipePart = RecipePart()
        recipePart.isUserInteractionEnabled = true
        recipePart.addGestureRecognizer(tap)
        return recipePart
    }
    
    @objc private func didTapOnRecipePart(_ sender: UITapGestureRecognizer) {
        assert(sender.view is RecipePart, "tap gesture not configured properly.")
        
        guard let recipePart = sender.view as? RecipePart else {
            return
        }
        
        delegate?.recipeBuildView(self, didSelectItemWithName: recipePart.itemName)
    }
}
