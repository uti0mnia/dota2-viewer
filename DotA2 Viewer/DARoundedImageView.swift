//
//  DACircleImageView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-11-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import ChameleonFramework

class DARoundedImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        // set properties
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        
        // set the corners
        self.layer.cornerRadius = Layout.roundedRectangleRadius
    }

}
