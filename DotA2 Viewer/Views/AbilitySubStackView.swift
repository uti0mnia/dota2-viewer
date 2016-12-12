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
    var typesLabel: DAMainLabel = {
        let label = DAMainLabel(style: .medium)
        label.numberOfLines = 0
        return label
    }()
    var summaryLabel = DAMainLabel(style: .medium)
    var dataLabel = DAMainLabel(style: .medium)
    var modifiersLabel = DAMainLabel(style: .medium)
    var notesSV = DAExpandableTextStackView(name: "Notes")

}
