//
//  AbilitiesStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-11.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class AbilitiesStackView: DAExpandableStackView {
    // MARK - Properties
    fileprivate var topLabel: DAMainLabel = {
        let label = DAMainLabel(style: .xlarge)
        label.text = "Abilities"
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    fileprivate var bottomSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        return sv
    }()
    fileprivate var count: Int = 0
    var subStackViews = [AbilityStackView]()
    
    
    // MARK - Initializers
    init(frame: CGRect = CGRect(), count: Int = 0) {
        self.count = count
        super.init(topView: topLabel, subView: nil, expanded: false, frame: frame)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Methods
    override internal func toggle() {
        if let sv = self.subView as? UIStackView {
            for view in sv.arrangedSubviews {
                if let abilitySV = view as? AbilityStackView {
                    if abilitySV.isExpanded {
                        abilitySV.forceExpanded(false)
                    }
                }
            }
        }
        super.toggle()
    }
    
    override internal func setSpacing(for sv: UIStackView) {
        super.setSpacing(for: sv)
        bottomSV.spacing = 0
    }
    
    
    fileprivate func configure() {
        // create <count> expandable stack views and add them
        for _ in 0..<self.count {
            let sv = AbilityStackView()
            subStackViews.append(sv)
            bottomSV.addArrangedSubview(sv)
        }
        
        self.setSubview(bottomSV)
    }
    
    

}




















