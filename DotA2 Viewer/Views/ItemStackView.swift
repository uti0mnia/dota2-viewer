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
    var mainView = ItemMainView()
    var detailsSV = DAExpandableTextStackView(name: "Details")
    var additionalInfoSV = DAExpandableTextStackView(name: "Additional Information")
    var loreSV = DAExpandableTextStackView(name: "Lore")
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .equalSpacing
        self.spacing = 8
        self.addArrangedSubviews(views: [mainView, detailsSV, additionalInfoSV, loreSV])
        self.layoutMargins = UIEdgeInsetsMake(8, 8, 8, 8)
        self.isLayoutMarginsRelativeArrangement =  true
    }

}
