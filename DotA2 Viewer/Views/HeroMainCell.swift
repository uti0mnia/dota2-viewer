//
//  HeroMainCellTableViewCell.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroMainCell: UITableViewCell {

    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var attackTypeLabel: UILabel!
    @IBOutlet weak var rolesLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var slider: DASlider!
    @IBOutlet weak var attribute1View: AttributeView!
    @IBOutlet weak var attribute2View: AttributeView!
    @IBOutlet weak var attribute3View: AttributeView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
}
