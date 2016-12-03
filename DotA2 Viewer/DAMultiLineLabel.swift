//
//  MultiLineLabel.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-26.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DAMultiLineLabel: DAMainLabel {

    override init(frame: CGRect, style: DAMainLabelStyle = .medium) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    convenience init(style: DAMainLabelStyle = .medium) {
        self.init(frame: CGRect(), style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.numberOfLines = 0
    }
}
