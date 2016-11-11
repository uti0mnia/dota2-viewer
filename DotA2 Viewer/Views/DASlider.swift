//
//  DASlider.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-11-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DASlider: UISlider {

    fileprivate let numbers = 1...25
    fileprivate var numberOfSteps: Int {
        get {
            return numbers.count
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // set the properties
        self.minimumTrackTintColor = UIColor.flatRed()
        self.maximumTrackTintColor = UIColor.flatWhite()
        self.thumbTintColor = UIColor.flatBlack()
        self.setValue(1, animated: false)
        self.minimumValue = 1
        self.maximumValue = Float(numberOfSteps)
        self.addTarget(self, action: #selector(DASlider.valueChanged(_:)), for: .valueChanged)
        
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func valueChanged(_ sender: UISlider) {
        let idx = Int(self.value + 0.5)
        self.setValue(Float(idx), animated: false)
        
    }

}
