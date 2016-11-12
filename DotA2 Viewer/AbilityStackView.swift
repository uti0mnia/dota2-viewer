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
    var youtubeButton: DAYouTubeButton?
    var loreLabel: UILabel!
    
    init(frame: CGRect, url: URL?) {
        name = DAMainLabel(style: .xlarge)
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
        manaLabel = DAMainLabel()
        manaLabel.textAlignment = .center
        cooldownLabel = DAMainLabel()
        cooldownLabel.textAlignment = .center
        let stackView = UIStackView(arrangedSubviews: [manaLabel, cooldownLabel])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        loreLabel = MultiLineLabel(style: .xsmall)
        
        if url != nil {
            //youtubeButton = DAYouTubeButton(url: url!)
        }
        
        
        // initialize self
        super.init(frame: frame)
        
        self.addArrangedSubviews(views: [name, imgStackView, descriptionLabel, dataLabel, stackView, youtubeButton, loreLabel])
        
        self.alignment = .fill
        self.axis = .vertical
        self.distribution = .fill
        self.spacing = 10
        
    }
    
    convenience init(url: URL?) {
        self.init(frame: CGRect(), url: url)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
