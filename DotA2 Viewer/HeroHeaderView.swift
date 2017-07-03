//
//  HeroStretchHeaderView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-11.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class HeroHeaderView: ObjectHeaderView {
    
    weak var delegate: HeroHeaderViewDelegate?
    
    public var detailsButton = UIButton()
    public var abilitiesButton = UIButton()
    public var talentsButton = UIButton()
    public var miscButton = UIButton()
    
    public override func initViews() {
        super.initViews()
        
        stackView.uti_addArrangedSubviews(views: [detailsButton, abilitiesButton, talentsButton, miscButton])
        
        detailsButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        detailsButton.setTitle("Details", for: .normal)
        detailsButton.tag = 0
        
        abilitiesButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        abilitiesButton.setTitle("Abilities", for: .normal)
        abilitiesButton.tag = 1
        
        talentsButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        talentsButton.setTitle("Talents", for: .normal)
        talentsButton.tag = 2
        
        miscButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        miscButton.setTitle("Misc", for: .normal)
        miscButton.tag = 3
    }
    
    override func didPanOnView(_ gesture: UIPanGestureRecognizer) {
        super.didPanOnView(gesture)
        
        delegate?.objectHeaderView(self, didChangeImageHeightTo: imageView.bounds.height)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let tab = HeroDetailTab(rawValue: sender.tag) else {
            assertionFailure("\(String(describing: self)) buttons not configured properly")
            return
        }
        
        delegate?.heroHeaderView(self, didTapTab: tab)
    }
    
}
