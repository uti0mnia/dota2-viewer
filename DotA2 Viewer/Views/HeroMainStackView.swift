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
    var imageView = DARoundedImageView(radius: 10)
    var attackTypeLabel = DAMainLabel(style: .medium, bold: true)
    var rolesLabel = DAMultiLineLabel(style: .medium)
    
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
        self.distribution = .fillProportionally
        self.spacing = 8
        
        // Add views
        self.addArrangedSubviews(views: [imageView, attackTypeLabel, rolesLabel])
    }
    

}




























