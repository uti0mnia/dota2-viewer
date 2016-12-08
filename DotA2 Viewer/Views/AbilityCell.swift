//
//  AbilityCell.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-08.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class AbilityCell: UITableViewCell, ExpandableCellProtocol {
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
    
    var isExpanded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
    }
    
    
    func toggle() {
        detailsVC.isHidden = !isExpanded
        isExpanded = !isExpanded
    }
    
    
    @IBAction func button(_ sender: Any) {
        print("Button")
    }
    
}













































