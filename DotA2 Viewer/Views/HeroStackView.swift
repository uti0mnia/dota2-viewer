//
//  HeroStackView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroStackView: UIStackView {
    // MARK - Properties
    var mainSV = HeroMainStackView()
    var statsSV = HeroStatsStackView()
    var abilitiesSV: AbilitiesStackView!
    var bioSV = DAExpandableTextStackView(name: "Bio")
    var loreSV = DAExpandableTextStackView(name: "Lore")
    
    // MARK - Initializers
    init(frame: CGRect = CGRect(), abilities count: Int) {
        abilitiesSV = AbilitiesStackView(count: count)
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Methods
    fileprivate func setup() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .equalSpacing
        self.spacing = 8
        self.addArrangedSubviews(views: [mainSV, statsSV, abilitiesSV, bioSV, loreSV])
        self.layoutMargins = UIEdgeInsetsMake(8, 8, 8, 8)
        self.isLayoutMarginsRelativeArrangement =  true
    }

}
