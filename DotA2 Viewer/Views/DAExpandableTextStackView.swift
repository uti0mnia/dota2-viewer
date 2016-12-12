//
//  ItemDetailStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DAExpandableTextStackView: DAExpandableStackView {
    // MARK - Properties
    var textLabel: DAMultiLineLabel!
    
    // MARK - Initializaers
    init(name: String, frame: CGRect = CGRect()) {
        // set the main label
        let topLabel = DAMainLabel(style: .large)
        topLabel.textAlignment = .center
        topLabel.text = name
        topLabel.sizeToFit()
        
        // set the text label
        textLabel = DAMultiLineLabel(style: .small)
        super.init(topView: topLabel, subView: textLabel, expanded: false, frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
