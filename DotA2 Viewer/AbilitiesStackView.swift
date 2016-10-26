//
//  AbilitiesStackView.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-26.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class AbilitiesStackView: UIStackView {

    var abilities: [Ability]!
    
    func setStack() {
        // make sure abilities isn't nil
        guard abilities != nil else { print("abilities nil..."); return }
        
        // set up one AbilityStackView per ability
        for ability in abilities {
            let stack = AbilityStackView()
            stack.setStack()
            
            // set its views
            stack.cooldownLabel.text = ability.cooldown
            stack.dataLabel.text = ability.data?.replacingOccurrences(of: ",", with: "\n") // it is how it's saved... TODO: Change CSV Files
            stack.descriptionLabel.text = ability.summary
            stack.image.image = ability.getImage()
            stack.loreLabel.text = ability.lore
            stack.manaLabel.text = ability.mana
            stack.name.text = ability.name
            
            // add it to self
            self.addArrangedSubview(stack)
        }
        
        self.alignment = .fill
        self.axis = .vertical
        self.distribution = .fill
        self.spacing = 8
        
        
    }

}
