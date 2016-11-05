//
//  HeroDetailStackView.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-25.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroDetailStackView: UIStackView {
    /* Outlets */
    var heroImage: UIImageView!
    var attackTypeLabel: UILabel!
    var roleLabel: UILabel!
    var intelligenceLabel: UILabel!
    var agilityLabel: UILabel!
    var strengthLabel: UILabel!
    var damageLabel: UILabel!
    var speedLabel: UILabel!
    var armorLabel: UILabel!
    var extraSegmentControl: UISegmentedControl!
    
    func setStack() {
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
        
        // set the primary stats stack view
        intelligenceLabel = UILabel()
        agilityLabel = UILabel()
        strengthLabel = UILabel()
        damageLabel = UILabel()
        speedLabel = UILabel()
        armorLabel = UILabel()
        let stackView1 = UIStackView(arrangedSubviews: [intelligenceLabel, agilityLabel, strengthLabel])
        let stackView2 = UIStackView(arrangedSubviews: [damageLabel, speedLabel, armorLabel])
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView1.axis = .vertical
        stackView2.axis = .vertical
        stackView1.alignment = .center
        stackView2.alignment = .center
        stackView1.distribution = .fillEqually
        stackView2.distribution = .fillEqually
        let pStackView = UIStackView(arrangedSubviews: [stackView1, stackView2])
        pStackView.axis = .horizontal
        pStackView.alignment = .center
        pStackView.distribution = .fillEqually
        
        // set up the segment controll
        extraSegmentControl = UISegmentedControl(items: ["Bio", "Stats", "Abilities"])
        extraSegmentControl.tintColor = UIColor.red
        extraSegmentControl.selectedSegmentIndex = 0
        
        // add the views to the stack vie
        for i in [imgSV, attackTypeLabel, roleLabel, pStackView, extraSegmentControl] as [UIView] {
            self.addArrangedSubview(i)
        }
        
        
        // settings
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 8
        self.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.isLayoutMarginsRelativeArrangement = true

    }
}
