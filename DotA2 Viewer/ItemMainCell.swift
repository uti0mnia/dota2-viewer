//
//  ItemMainCell.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-09.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class ItemMainCell: UITableViewCell {
    // MARK - Outlets
    @IBOutlet weak var mainSV: UIStackView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
