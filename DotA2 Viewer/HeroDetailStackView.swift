//
//  HeroDetailStackView.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-25.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroDetailStackView: UIStackView {
    /* Properties */
    var heroImage: UIImageView!
    var attackTypeLabel: UILabel!
    var roleLabel: UILabel!
    var statsStackView: StatsStackView!
    var extraSegmentControl: UISegmentedControl!
    
    init(attributeSet set: AttributeSet, stats: Stats) {
        // set the top values
        heroImage = UIImageView()
        let imgSV = UIStackView(arrangedSubviews: [heroImage])
        imgSV.axis = .vertical
        imgSV.alignment = .center
        imgSV.distribution = .fill
        
        attackTypeLabel = UILabel()
        attackTypeLabel.textAlignment = .center
        roleLabel = MultiLineLabel()
        roleLabel.textAlignment = .center
        
        // set the stats view
        statsStackView = StatsStackView(attributeSet: set, stats: stats)
        
        // set up the segment controll
        extraSegmentControl = UISegmentedControl(items: ["Bio", "Stats", "Abilities"])
        extraSegmentControl.tintColor = UIColor.red
        extraSegmentControl.selectedSegmentIndex = 0
        
        
        super.init(frame: CGRect())
        
        self.addArrangedSubviews(views: [heroImage, attackTypeLabel, roleLabel, statsStackView, extraSegmentControl])
        
        // settings
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 8
        self.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.isLayoutMarginsRelativeArrangement = true

    }
}
