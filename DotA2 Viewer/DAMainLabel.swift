//
//  DAMainLabel.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-11-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import ChameleonFramework

class DAMainLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // set the text colour
        self.textColor = UIColor.flatWhite()
        
        // set the font
        self.font = UIFont(name: "TrajanPro-Regular", size: 16)
    }
    
    convenience init() {
        self.init(frame: CGRect())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
