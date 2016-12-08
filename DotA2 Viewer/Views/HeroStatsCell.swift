//
//  HeroStatsCell.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroStatsCell: UITableViewCell, ExpandableCellProtocol {
    // MARK - Outlets
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var baseStatsView: BaseStatsView!
    @IBOutlet weak var miscStatsView: MiscStatsView!
    
    // MARK - Properties
    var isExpanded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if #available(iOS 10, *) {
            UIView.animate(withDuration: kCellAnimationTime) { self.contentView.layoutIfNeeded() }
        }
    }
    
    /* This function is to toggle what the uistackview holds */
    func toggle() {
        baseStatsView.isHidden = !isExpanded
        miscStatsView.isHidden = !isExpanded
        isExpanded = !isExpanded
    }
}
