//
//  HeroTalentStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-19.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroSingleTalentStackView: UIStackView {
    // MARK - Properties
    var leftLabel: DAMultiLineLabel = {
        let lbl = DAMultiLineLabel(style: .medium)
        lbl.textAlignment = .center
        return lbl
    }()
    var levelLabel: DAMainLabel = {
        let lbl = DAMainLabel(style: .large, bold: true)
        lbl.textAlignment = .center
        return lbl
    }()
    var rightLabel: DAMultiLineLabel = {
        let lbl = DAMultiLineLabel(style: .medium)
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        // set properties
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillProportionally
        
        let bottomSV = createBottomSV()
        bottomSV.addArrangedSubviews(views: [leftLabel, rightLabel])
        self.addArrangedSubviews(views: [levelLabel, bottomSV])
    }
    
    fileprivate func createBottomSV() -> UIStackView {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }

}


































