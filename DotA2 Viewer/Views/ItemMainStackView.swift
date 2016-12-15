//
//  ItemMainStackView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-12.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class ItemMainStackView: DAStackView {
    // MARK - Properties
    /* Private */
    fileprivate var rightSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 8
        return sv
    }()
    fileprivate var topSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        return sv
    }()
    /* Public */
    var itemImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.borderColor = UIColor.flatWhite().cgColor
        iv.layer.borderWidth = 2.0
        return iv
    }()
    var costLabel = DAIconLabel(style: .medium)
    var availabilityLabel: DAIconLabel = {
        let label = DAIconLabel(style: .small)
        label.textAlignment = .right
        return label
    } ()
    var typeLabel = DAMainLabel(style: .medium)
    var typeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .left
        return iv
    }()
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Methods
    fileprivate func setup() {
        // setup self
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fillProportionally
        self.spacing = 14
        
        // add views
        topSV.addArrangedSubviews(views: [costLabel, availabilityLabel])
        rightSV.addArrangedSubviews(views: [topSV, typeLabel, typeImageView])
        self.addArrangedSubviews(views: [itemImageView, rightSV])
    }
    
    

}




































