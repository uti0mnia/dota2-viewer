//
//  HeroTalentSubStackView.swift
//  
//
//  Created by Casey McLewin on 2016-12-19.
//
//

import UIKit

class HeroTalentSubStackView: UIStackView {
    // MARK - Properties
    var talent1 = HeroSingleTalentStackView()
    var talent2 = HeroSingleTalentStackView()
    var talent3 = HeroSingleTalentStackView()
    var talent4 = HeroSingleTalentStackView()
    var talentNotes = DAExpandableTextStackView(name: "Notes", style: .large)
    
    var talents: [HeroSingleTalentStackView] { get { return [talent1, talent2, talent3, talent4] } }
    
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
        self.distribution = .equalSpacing
        self.addArrangedSubviews(views: [talent1, talent2, talent3, talent4, talentNotes])
    }
    
}
