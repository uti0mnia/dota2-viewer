//
//  AbilitiesStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-11.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class AbilitiesStackView: UIStackView {
    // MARK - Properties
    fileprivate var topLabel: DAMainLabel = {
        let label = DAMainLabel(style: .large)
        label.text = ""
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    fileprivate var subStackViews = [AbilityStackView]()
    
    
    // MARK - Initializers
    init(frame: CGRect = CGRect(), count: Int = 0) {
        super.init(frame: frame)
        
        // create <count> expandable stack views and add them
        for _ in 0..<count {
            let sv = AbilityStackView()
            subStackViews.append(sv)
        }
        self.addArrangedSubviews(views: subStackViews)
        
        // setup
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Methods
    fileprivate func setup() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillProportionally
        self.spacing = 8
    }

}
