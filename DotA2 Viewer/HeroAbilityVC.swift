//
//  HeroAbilityVC.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-24.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroAbilityVC: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var cooldownLabel: UILabel!
    @IBOutlet weak var loreLabel: UILabel!
    
    var ability: Ability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setView()
    }
    
    
    fileprivate func setView() {
        guard ability != nil else { return }
        
        nameLabel.text = ability.name
        imageView.image = ability.getImage()
        descriptionLabel.text = ability.summary
        dataLabel.text = ability.data
        manaLabel.text = ability.mana
        cooldownLabel.text = ability.cooldown
        loreLabel.text = ability.lore
    }
    
    @IBAction func youtubeButtonPressed(_ sender: UIButton) {
        
    }
    
}
