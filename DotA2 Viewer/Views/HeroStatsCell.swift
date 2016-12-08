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
    fileprivate var children: [UIView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    /* This function is to toggle what the uistackview holds */
    func toggle() {
        baseStatsView.isHidden = !baseStatsView.isHidden
        miscStatsView.isHidden = !miscStatsView.isHidden
        isExpanded = !isExpanded
    }
}
