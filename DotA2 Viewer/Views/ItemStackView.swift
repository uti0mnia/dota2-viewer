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
    var abilitiesSV: AbilitiesStackView?
    var additionalInfoSV = DAExpandableTextStackView(name: "Additional Information")
    var loreSV = DAExpandableTextStackView(name: "Lore")
    
    init(frame: CGRect = CGRect(), abilitiesCount count: Int) {
        if count > 0 {
            self.abilitiesSV = AbilitiesStackView(count: count)
        }
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
        self.addArrangedSubviews(views: [mainView, detailsSV, abilitiesSV, additionalInfoSV, loreSV])
        self.layoutMargins = UIEdgeInsetsMake(8, 8, 8, 8)
        self.isLayoutMarginsRelativeArrangement =  true
    }

}
