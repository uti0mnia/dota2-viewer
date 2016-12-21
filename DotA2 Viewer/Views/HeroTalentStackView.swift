//
//  HeroTalentStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-19.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroTalentStackView: DAExpandableStackView {
    // MARK - Properties
    var topLabel: DAMainLabel = {
        let lbl = DAMainLabel(style: .xlarge, bold: true)
        lbl.text = "Talents"
        return lbl
    }()
    
    init(frame: CGRect = CGRect()) {
        super.init(topView: topLabel, expanded: false, frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
