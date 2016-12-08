//
//  DACollapsibleLabelCell.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-08.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DACollapsibleLabelCell: UITableViewCell, ExpandableCellProtocol {
    // MARK - Outlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collapsibleTextLabel: UILabel!
    
    // MARK - Properties
    var isExpanded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
    }

    func toggle() {
        collapsibleTextLabel.isHidden = !isExpanded
        isExpanded = !isExpanded
    }
    
}
