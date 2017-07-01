//
//  HeroStretchHeaderView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-11.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class ItemHeaderView: ObjectHeaderView {
    
    weak var delegate: ItemHeaderViewDelegate?
    
    private var detailsButton = UIButton()
    private var abilitiesButton = UIButton()
    
    public override func initViews() {
        super.initViews()
        
        stackView.uti_addArrangedSubviews(views: [detailsButton, abilitiesButton])
        
        detailsButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        detailsButton.setTitle("Details", for: .normal)
        detailsButton.tag = 0
        
        abilitiesButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        abilitiesButton.setTitle("Abilities", for: .normal)
        abilitiesButton.tag = 1
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let tab = ItemDetailTab(rawValue: sender.tag) else {
            assertionFailure("\(String(describing: self)) buttons not configured properly")
            return
        }
        
        delegate?.itemHeaderView(self, didTapTab: tab)
    }
    
}
