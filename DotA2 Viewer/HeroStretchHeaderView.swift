//
//  HeroStretchHeaderView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-11.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class HeroStretchHeaderView: GSKStretchyHeaderView {
    weak var delegate: HeroStretchHeaderViewDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var abilitiesButton: UIButton!
    @IBOutlet weak var talentsButton: UIButton!
    @IBOutlet weak var miscButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailsButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        abilitiesButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        talentsButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        miscButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        detailsButton.tag = 0
        abilitiesButton.tag = 1
        talentsButton.tag = 2
        miscButton.tag = 3
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        if let tab = HeroDetailTab(rawValue: sender.tag) {
            delegate?.heroStretchHeaderView(self, didTapTab: tab)
        } else {
            assert(false, "HeroStretchHeaderView buttons not configured properly")
        }
    }
    
}
