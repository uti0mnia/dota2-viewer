//
//  HeroStatsStackView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroStatsSubStackView: UIStackView {
    // MARK - Properties
    fileprivate let kLabelHeight: CGFloat = 30
    // top
    var levelLabel: DAMainLabel = {
        let lbl = DAMainLabel(style: .large, bold: true)
        lbl.textAlignment = .center
        return lbl
    }()
    var slider = DASlider()
    
    // middle
    var strengthSV = HeroAttributeStackView()
    var agilitySV = HeroAttributeStackView()
    var intelligenceSV = HeroAttributeStackView()
    var hpLabel: DAMainLabel = {
        let lbl = DAMainLabel(style: .medium, bold: true)
        lbl.textColor = UIColor.flatBlack()
        lbl.backgroundColor = UIColor.flatGreen()
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 4
        lbl.clipsToBounds = true
        return lbl
    }()
    var manaLabel: DAMainLabel = {
        let lbl = DAMainLabel(style: .medium, bold: true)
        lbl.textColor = UIColor.flatBlack()
        lbl.backgroundColor = UIColor.flatSkyBlue()
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 4
        lbl.clipsToBounds = true
        return lbl
    }()
    
    // bottom
    var damageLabel = DAMainLabel(style: .medium)
    var attackPerSLabel = DAMainLabel(style: .medium)
    var armorLabel = DAMainLabel(style: .medium)
    var spellDmgLabel = DAMainLabel(style: .medium)
    var attackAnimationLabel = DAMainLabel(style: .medium)
    var attackRangeLabel = DAMainLabel(style: .medium)
    var moveSpeedLabel = DAMainLabel(style: .medium)
    var projectileSpeedLabel = DAMainLabel(style: .medium)
    var collisionSizeLabel = DAMainLabel(style: .medium)
    var magicResistanceLabel = DAMainLabel(style: .medium)
    var turnRateLabel = DAMainLabel(style: .medium)
    var visionLabel = DAMainLabel(style: .medium)
    
    
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
        // Configure properties
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillProportionally
        
        // constraints
        setConstraints()
        
        // create SV
        let topSV = createTopSV()
        let middleSV = createMiddleSV()
        let bottomSV = createBottomSV()
        
        self.addArrangedSubviews(views: [topSV, middleSV, bottomSV])
        
    }
    
    fileprivate func createTopSV() -> UIStackView {
        let topSV = UIStackView(arrangedSubviews: [levelLabel, slider])
        topSV.axis = .vertical
        topSV.alignment = .fill
        topSV.distribution = .fillProportionally
        return topSV
    }
    
    fileprivate func createMiddleSV() -> UIStackView {
        // left SV
        let leftSV = UIStackView(arrangedSubviews: [strengthSV, agilitySV, intelligenceSV])
        leftSV.axis = .horizontal
        leftSV.alignment = .fill
        leftSV.distribution = .fillEqually
        
        // right SV
        let rightSV = UIStackView(arrangedSubviews: [hpLabel, manaLabel])
        rightSV.axis = .vertical
        rightSV.alignment = .fill
        rightSV.distribution = .fillProportionally
        
        // middle SV
        let middleSV = UIStackView(arrangedSubviews: [leftSV, rightSV])
        middleSV.axis = .vertical
        middleSV.alignment = .fill
        middleSV.distribution = .fillEqually
        return middleSV
    }
    
    fileprivate func setConstraints() {
        // hp label
//        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[lbl(height)]", options: [], metrics: ["height": kLabelHeight], views: ["lbl": hpLabel])
//        constraints.forEach({ $0.priority = 999 })
//        hpLabel.addConstraints(constraints)
        
        // mana label
//        constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[lbl(height)]", options: [], metrics: ["height": kLabelHeight], views: ["lbl": manaLabel])
//        constraints.forEach({ $0.priority = 999 })
//        manaLabel.addConstraints(constraints)
    }
    
    fileprivate func createBottomSV() -> UIStackView {
        // left SV
        let leftSV = UIStackView(arrangedSubviews: [damageLabel, armorLabel, attackAnimationLabel, moveSpeedLabel, collisionSizeLabel, turnRateLabel])
        leftSV.axis = .vertical
        leftSV.alignment = .center
        leftSV.distribution = .fillEqually
        
        // right SV
        let rightSV = UIStackView(arrangedSubviews: [attackPerSLabel, spellDmgLabel, attackRangeLabel, projectileSpeedLabel, magicResistanceLabel, visionLabel])
        rightSV.axis = .vertical
        rightSV.alignment = .center
        rightSV.distribution = .fillEqually
        
        // bottom sv
        let bottomSV = UIStackView(arrangedSubviews: [leftSV, rightSV])
        bottomSV.axis = .horizontal
        bottomSV.alignment = .fill
        bottomSV.distribution = .fillEqually
        return bottomSV
    }
    

}





































