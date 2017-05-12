//
//  HeroMainStackView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroMainStackView: UIStackView {
    // MARK - Properties
    var imageView = DARoundedImageView(radius: 5)
    var attackTypeLabel: DAMainLabel = {
        let label = DAMainLabel(style: .medium, bold: true)
        label.textAlignment = .center
        return label
    }()
    var rolesLabel: DAMainLabel = {
        let lbl = DAMainLabel(style: .medium)
        lbl.textAlignment = .center
        return lbl
    }()
    
    // MARK - Initializers
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Methods
    fileprivate func setup() {
        // Configure properties
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .equalSpacing
        self.spacing = 12
        
        // Add views
        self.addArrangedSubviews(views: [imageView, attackTypeLabel, rolesLabel])
    }
    

}




























