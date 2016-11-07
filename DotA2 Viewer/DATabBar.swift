//
//  DATabBar.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-11-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DATabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // set the colour
        self.barTintColor = UIColor.flatBlack()
        self.isTranslucent = false
        self.tintColor = UIColor.flatRed()
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("coder wasn't implemented")
        
    }

    
    
}
