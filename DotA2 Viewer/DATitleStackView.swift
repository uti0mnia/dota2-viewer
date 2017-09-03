//
//  DATitleView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-04.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class DATitleStackView: UIStackView {
    
    private(set) var titleLabel = DALabel()
    private weak var currentSubview: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        axis = .vertical
        distribution = .fillProportionally
        spacing = Layout.defaultPadding
        
        titleLabel.font = Fonts.subtitle.bold
        titleLabel.textAlignment = .center
        addArrangedSubview(titleLabel)
    }
    
    public func setDetailView(_ newView: UIView) {
        currentSubview?.removeFromSuperview()
        
        addArrangedSubview(newView)
        
        currentSubview = newView
    }
    
}
