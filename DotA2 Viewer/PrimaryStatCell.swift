//
//  PrimaryStatCell.swift
//  hero-view
//
//  Created by McLewin, Casey on 2016-10-05.
//  Copyright © 2016 uti0mnia. All rights reserved.
//

import UIKit

enum PrimaryAttribute: Int {
    case strength = 0, agility, intelligence
}

class PrimaryStatCell: UITableViewCell {
    
    /* Properties */
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var agilityLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var movementSpeedLabel: UILabel!
    @IBOutlet weak var armorLabel: UILabel!

    // TODO: make primary stat picture
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
