//
//  HeroBioCell.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroBioCell: UITableViewCell, ExpandableCellProtocol {
    // MARK - Outlets
    @IBOutlet weak var bioLabel: UILabel!
    var isExpanded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    func toggle() {
        bioLabel.isHidden = !isExpanded
        isExpanded = !isExpanded
    }
}
