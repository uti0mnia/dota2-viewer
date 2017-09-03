//
//  DASeparatorView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-09-02.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class DASeparatorView: UIView {
    
    private static let verticalPadding: CGFloat = 10
    private static let insets = UIEdgeInsets(top: DASeparatorView.verticalPadding, left: 0, bottom: DASeparatorView.verticalPadding, right: 0)
    
    private var separatorView = UIView()
    
    public var separatorColour = Colours.defaultTextColour {
        didSet {
            separatorView.backgroundColor = separatorColour
        }
    }
    
    public var separatorThickness: CGFloat = 1 {
        didSet {
            separatorView.snp.makeConstraints() { make in
                make.height.equalTo(separatorThickness)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        separatorView.backgroundColor = separatorColour
        
        addSubview(separatorView)
        
        separatorView.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalToSuperview().inset(DASeparatorView.insets)
             make.height.equalTo(separatorThickness)
        }
    }
}
