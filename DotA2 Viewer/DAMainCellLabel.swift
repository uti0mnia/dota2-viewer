//
//  DAMainCellLabel.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-11-08.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DAMainCellLabel: DAMainLabel {

    init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // set the font
        self.font = kDotaFontLarge
    }
    
    convenience init() {
        self.init(frame: CGRect())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
