//
//  PrimaryStatVC.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-22.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class PrimaryStatVC: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var agilityLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var armorLabel: UILabel!
    
    var stat: PrimaryStat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setView()
    }
    
    private func setView() {
        guard stat != nil else { print("stat nil");return }
        
        // set values
        intelligenceLabel.text = stat.intelligence
        agilityLabel.text = stat.agility
        strengthLabel.text = stat.strength
        damageLabel.text = stat.damage
        speedLabel.text = stat.speed
        armorLabel.text = stat.armor
    }

}
