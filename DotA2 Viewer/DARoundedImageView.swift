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
    // MARK - Properties
    fileprivate var radius: CGFloat!
    
    init(frame: CGRect = CGRect(), radius: CGFloat = 2) {
        self.radius = radius
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        // set properties
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        
        // set the corners
        self.layer.cornerRadius = radius
        
        // set the contour to be white
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.flatWhite().cgColor
    }

}
