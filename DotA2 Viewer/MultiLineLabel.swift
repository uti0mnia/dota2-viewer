//
//  MultiLineLabel.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-26.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class MultiLineLabel: DAMainLabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.numberOfLines = 0
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
