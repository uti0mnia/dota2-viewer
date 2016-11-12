//
//  DAYouTubeButton.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-11-12.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DAYouTubeButton: UIButton {

    var url: URL!
    
    init(frame: CGRect, url: URL) {
        self.url = url
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.tintColor = UIColor.flatWhite()
        self.titleLabel?.textColor = UIColor.flatWhite()
        self.titleLabel?.font = kRadiance
        self.setTitle("YouTube", for: .normal)
    }
    
    convenience init(url: URL) {
        self.init(frame: CGRect(), url: url)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
