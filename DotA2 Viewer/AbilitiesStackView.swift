//
//  AbilitiesStackView.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-26.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import SafariServices

class AbilitiesStackView: UIStackView {

    var abilities: [Ability]!
    
    func setStack() {
        // make sure abilities isn't nil
        guard abilities != nil else { print("abilities nil..."); return }
        
        // set up one AbilityStackView per ability
        for ability in abilities {
            let url = URL(string: ability.videoURL.replacingOccurrences(of: "www", with: "m"))
            let stack = AbilityStackView(url: url)
            
            // set its views
            stack.cooldownLabel.text = ability.cooldown
            stack.dataLabel.text = ability.data?.replacingOccurrences(of: ",", with: "\n") // it is how it's saved... TODO: Change CSV Files
            stack.descriptionLabel.text = ability.summary
            stack.image.image = ability.getImage()
            stack.loreLabel.text = ability.lore
            stack.manaLabel.text = ability.mana
            stack.name.text = ability.name
            
            // set up the youtube button
            stack.youtubeButton?.addTarget(self, action: #selector(AbilitiesStackView.openYoutubeButton(_:)), for: .touchUpInside)
            
            // add it to self
            self.addArrangedSubview(stack)
        }
        
        self.alignment = .fill
        self.axis = .vertical
        self.distribution = .fill
        self.spacing = 8
        
    }
    
    @objc func openYoutubeButton(_ sender: DAYouTubeButton) {
        let svc = SFSafariViewController(url: sender.url)
        UIApplication.shared.keyWindow?.rootViewController?.present(svc, animated: true, completion: nil)
    }

}
