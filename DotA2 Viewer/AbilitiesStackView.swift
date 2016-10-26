//
//  AbilitiesStackView.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-25.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class AbilitiesStackView: UIStackView {

    var image: UIImageView!
    var descriptionLabel: UILabel!
    var dataLabel: UILabel!
    var manaLabel: UILabel!
    var cooldownLabel: UILabel!
    var youtubeButton: UIButton!
    var loreLabel: UILabel!
    
    func setStack() {
        image = UIImageView()
        descriptionLabel = UILabel()
        dataLabel = UILabel()
        
        // stack view for mana/cooldown label
        manaLabel = UILabel()
        cooldownLabel = UILabel()
        let stackView = UIStackView(arrangedSubviews: [manaLabel, cooldownLabel])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        youtubeButton = UIButton(type: .custom)
        youtubeButton.setTitle("YouTube", for: .normal)
        loreLabel = UILabel()
        
        for i in [image, descriptionLabel, dataLabel, stackView, youtubeButton, loreLabel] {
            self.addArrangedSubview(i)
        }
    }

}
