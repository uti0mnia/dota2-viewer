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
    fileprivate var initialLevel = 1
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
        self.initialLevel = level
        
        super.init(frame: frame)
        
        setup()
        
    }
    
    convenience init(initialLevel level: Int = 1) {
        self.init(frame: CGRect(), initialLevel: level)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        // set the properties
        self.minimumTrackTintColor = UIColor.flatRed()
        self.maximumTrackTintColor = UIColor.flatWhite()
        self.thumbTintColor = UIColor.black
        self.setValue(1, animated: false)
        self.minimumValue = Float(numbers.first!)
        self.maximumValue = Float(numbers.last!)
        self.addTarget(self, action: #selector(DASlider.valueChanged(_:)), for: .valueChanged)
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

















