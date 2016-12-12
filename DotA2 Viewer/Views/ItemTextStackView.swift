//
//  ItemDetailStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class ItemTextStackView: DAExpandableStackView {
    // MARK - Properties
    var textLabel: DAMainLabel!
    
    // MARK - Initializaers
    init(name: String, frame: CGRect = CGRect()) {
        textLabel = DAMainLabel(style: .small)
        textLabel.numberOfLines = 0
        super.init(name: name, subView: textLabel, expanded: false, frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
