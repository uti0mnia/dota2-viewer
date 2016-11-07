//
//  DACircleImageView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-11-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import ChameleonFramework

class DACircleImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // set the contour to be white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.flatWhite().cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // set the image to be a cicle
        // we need to do this in layout subview since we don't know it's frame until its image is set
        self.layer.cornerRadius = min(self.frame.height, self.frame.width) / 2
        self.clipsToBounds = true
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
