//
//  DALoreLabel.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-11-13.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DALoreLabel: MultiLineLabel {

    init(frame: CGRect) {
        super.init(frame: frame, style: .small)
        
        self.textColor = UIColor.flatGray()
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
