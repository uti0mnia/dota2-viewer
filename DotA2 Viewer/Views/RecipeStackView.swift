//
//  RecipeStackView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-13.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class RecipeStackView: DAExpandableStackView {
    // MARK - Properties
    var textLabel: DAMainLabel!
    
    // MARK - Initializer
    init(frame: CGRect = CGRect()) {
        // set the main label
        textLabel = DAMainLabel(style: .xlarge, bold: true)
        textLabel.text = "Recipe"
        textLabel.sizeToFit()
        
        super.init(topView: textLabel, expanded: false, frame: frame)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
