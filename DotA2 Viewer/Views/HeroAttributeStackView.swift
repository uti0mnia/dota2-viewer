//
//  HeroAttributeStackView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroAttributeStackView: DAStackView {
    // MARK - Properties
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    var label = DAMainLabel(style: .medium)
    
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
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fillProportionally
        
        self.addArrangedSubviews(views: [imageView, label])
    }

}
