//
//  DASlider.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-11-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

protocol DASliderDelegate {
    func slider(_ slider: DASlider, didUpdateTo value: Int)
}

class DASlider: UISlider {

    fileprivate let numbers = 1...25
    fileprivate var numberOfSteps: Int {
        get {
            return numbers.count
        }
    }
    fileprivate var oldValue: Int?
    
    
    var delegate: DASliderDelegate?
    
    init(frame: CGRect, initialLevel lvl: Int = 1) {
        // make sure level isn't outside of range
        var level = lvl > 25 ? 25 : lvl
        level = lvl < 1 ? 1 : level
        
        super.init(frame: frame)
        
        // set the properties
        self.minimumTrackTintColor = UIColor.flatRed()
        self.maximumTrackTintColor = UIColor.flatWhite()
        self.thumbTintColor = UIColor.flatBlue()
        self.setValue(1, animated: false)
        self.minimumValue = Float(level)
        self.maximumValue = Float(numberOfSteps)
        self.addTarget(self, action: #selector(DASlider.valueChanged(_:)), for: .valueChanged)
        
    }
    
    convenience init(initialLevel level: Int = 1) {
        self.init(frame: CGRect(), initialLevel: level)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func valueChanged(_ sender: UISlider) {
        let idx = Int(self.value + 0.5)
        self.setValue(Float(idx), animated: false)
        
        // for the delegate method
        if oldValue != idx {
            oldValue = idx
            delegate?.slider(self, didUpdateTo: idx)
        }
        
    }

}

















