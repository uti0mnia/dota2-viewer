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
    var attackTypeLabel: DAMainLabel!
    var roleLabel: MultiLineLabel!
    var statsStackView: StatsStackView!
    var extraSegmentControl: UISegmentedControl!
    
    init(attributeSet set: AttributeSet, stats: Stats) {
        // set the top values
        heroImage = UIImageView()
        let imgSV = UIStackView(arrangedSubviews: [heroImage])
        imgSV.axis = .vertical
        imgSV.alignment = .center
        imgSV.distribution = .fill
        
        attackTypeLabel = DAMainLabel()
        attackTypeLabel.textAlignment = .center
        roleLabel = MultiLineLabel()
        roleLabel.textAlignment = .center
        
        // set the stats view
        statsStackView = StatsStackView(attributeSet: set, stats: stats)
        
        // set up the segment controll
        extraSegmentControl = UISegmentedControl(items: ["Bio", "Abilities"])
        extraSegmentControl.tintColor = UIColor.red
        extraSegmentControl.selectedSegmentIndex = 0
        
        
        super.init(frame: CGRect())
        
        self.addArrangedSubviews(views: [imgSV, attackTypeLabel, roleLabel, statsStackView, extraSegmentControl])
        
        // settings
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.layoutMargins = UIEdgeInsetsMake(0, 20, 0, 20)
        self.spacing = 16

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
