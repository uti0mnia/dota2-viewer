//
//  AbilityStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-11.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class AbilityStackView: DAExpandableStackView {
    // MARK - Properties
    /* Private */
    fileprivate var topSV: UIStackView  = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        return sv
    }()
    
    /* Public */
    var nameLabel = DAMainLabel(style: .large)
    var specialsLabel: DAMainLabel = {
        let label = DAMainLabel(style: .medium)
        label.textAlignment = .right
        return label
    }()
    
    // MARK - Initializers
    init(frame: CGRect = CGRect()) {
        nameLabel.setContentCompressionResistancePriority(751, for: .horizontal)
        topSV.addArrangedSubviews(views: [nameLabel, specialsLabel])
        super.init(topView: topSV, subView: nil, expanded: false, frame: frame)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override internal func setSpacing(for sv: UIStackView) {
        super.setSpacing(for: sv)
        
        
        // set the margins
        let margins: CGFloat = isExpanded ? 4 : 0
        self.layoutMargins = UIEdgeInsetsMake(margins, 0, margins, 0)
        self.isLayoutMarginsRelativeArrangement = true
    }
    
    

}



























