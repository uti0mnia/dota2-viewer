//
//  ExpandableCellProtocol.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

protocol ExpandableCellProtocol {
    var isExpanded: Bool { get set }
    func toggle()
    func setSpacing(for sv: UIStackView)
}

class ExpandableCell: UITableViewCell, ExpandableCellProtocol {
    // MARK - Properties
    var isExpanded: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        toggle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if #available(iOS 10, *) {
            UIView.animate(withDuration: kCellAnimationTime) { self.contentView.layoutIfNeeded() }
        }
    }
    
    /* This function is to toggle what the uistackview holds */
    func toggle() {
        isExpanded = !isExpanded
    }
    
    internal func setSpacing(for sv: UIStackView) {
        let space: CGFloat = isExpanded ? 8 : 0 // set the spacing required
        sv.spacing = space
        for view in sv.arrangedSubviews {
            if let sv = view as? UIStackView {
                setSpacing(for: sv)
            }
        }
    }
}
