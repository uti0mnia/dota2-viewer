//
//  AbilityCell.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-08.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class AbilityCell: ExpandableCell {
    // MARK - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsVC: UIStackView!
    @IBOutlet weak var abilityImageView: UIImageView!
    @IBOutlet weak var cooldownLabel: UILabel!
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var modifiersLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var notesDetails: UILabel!
    
    override func toggle() {
        super.toggle()
        
        setSpacing(for: detailsVC)
        detailsVC.isHidden = !isExpanded
    }
    
    
    @IBAction func button(_ sender: Any) {
        print("Button")
    }
    
}













































