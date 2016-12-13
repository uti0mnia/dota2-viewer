//
//  AbilitySubStackView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-12.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class AbilitySubStackView: UIStackView {
    // MARK - Properties
    /* Private */
    fileprivate var midSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        sv.spacing = 8
        return sv
    }()
    fileprivate var sideSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        sv.spacing = 8
        return sv
    }()
    
    /* Public */
    var abilityImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    var cooldownLabel = DAMainLabel(style: .medium)
    var manaLabel = DAMainLabel(style: .medium)
    var typesLabel = DAMultiLineLabel(style: .medium)
    var summaryLabel = DAMultiLineLabel(style: .medium)
    var dataLabel = DAMultiLineLabel(style: .medium)
    var modifiersLabel = DAMultiLineLabel(style: .medium)
    var notesSV = DAExpandableTextStackView(name: "Notes")
    
    // MARK - Initializers
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK - Methods
    /* Private */
    fileprivate func setup() {
        // setup properties
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .equalSpacing
        self.spacing = 8
        
        // add subview
        sideSV.addArrangedSubviews(views: [typesLabel, cooldownLabel, manaLabel])
        midSV.addArrangedSubviews(views: [abilityImageView, sideSV])
        self.addArrangedSubviews(views: [midSV, summaryLabel, dataLabel, modifiersLabel, notesSV])
    }

}




































