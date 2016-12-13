//
//  ItemStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class ItemStackView: UIStackView {
    // MARK - Properties
    var mainSV = ItemMainStackView()
    var recipeSV: RecipeStackView?
    var detailsSV = DAExpandableTextStackView(name: "Details")
    var abilitiesSV: AbilitiesStackView?
    var additionalInfoSV = DAExpandableTextStackView(name: "Additional Information")
    var loreSV = DAExpandableTextStackView(name: "Lore")
    
    
    // MARK - Initializers
    init(frame: CGRect = CGRect(), abilitiesCount count: Int, withRecipe: Bool) {
        if count > 0 {
            abilitiesSV = AbilitiesStackView(count: count)
        }
        if withRecipe {
            recipeSV = RecipeStackView()
        }
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Methods
    fileprivate func setup() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .equalSpacing
        self.spacing = 8
        self.addArrangedSubviews(views: [mainSV, recipeSV, detailsSV, abilitiesSV, additionalInfoSV, loreSV])
        self.layoutMargins = UIEdgeInsetsMake(8, 8, 8, 8)
        self.isLayoutMarginsRelativeArrangement =  true
    }

}
