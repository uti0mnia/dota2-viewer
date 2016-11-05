//
//  AbilitiesStackView.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-25.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class AbilityStackView: UIStackView {

    var name: UILabel!
    var image: UIImageView!
    var descriptionLabel: UILabel!
    var dataLabel: UILabel!
    var manaLabel: UILabel!
    var cooldownLabel: UILabel!
    var youtubeButton: UIButton!
    var loreLabel: UILabel!
    
    func setStack() {
        name = UILabel()
        name.textAlignment = .center
        
        // set the image stack view so that the image isn't distorted
        image = UIImageView()
        let imgStackView = UIStackView(arrangedSubviews: [image])
        imgStackView.axis = .vertical
        imgStackView.alignment = .center
        imgStackView.distribution = .fill
        
        // set the labels
        descriptionLabel = MultiLineLabel()
        dataLabel = MultiLineLabel()
        
        // stack view for mana/cooldown label
        manaLabel = UILabel()
        manaLabel.textAlignment = .center
        cooldownLabel = UILabel()
        cooldownLabel.textAlignment = .center
        let stackView = UIStackView(arrangedSubviews: [manaLabel, cooldownLabel])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        youtubeButton = UIButton(type: .system)
        youtubeButton.setTitle("YouTube", for: .normal)
        loreLabel = MultiLineLabel()
        
        
        self.alignment = .fill
        self.axis = .vertical
        self.distribution = .fill
        self.spacing = 6
        
        for i in [name, imgStackView, descriptionLabel, dataLabel, stackView, youtubeButton, loreLabel] as [UIView] {
            self.addArrangedSubview(i)
        }
        
        
    }

}
