//
//  HeroStatsStackView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroStatsStackView: DAExpandableStackView {
    // MARK - Properties
    var topLabel: DAMainLabel = {
        let lbl = DAMainLabel(style: .xlarge, bold: true)
        lbl.text = "Stats"
        return lbl
    }()
    
    init(frame: CGRect = CGRect()) {
        super.init(topView: topLabel, expanded: true, frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
