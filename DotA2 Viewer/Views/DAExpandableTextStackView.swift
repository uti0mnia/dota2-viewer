//
//  ItemDetailStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DAExpandableTextStackView: DAExpandableStackView {
    // MARK - Properties
    var textLabel: DAMultiLineLabel!
    
    // MARK - Initializaers
    init(name: String, frame: CGRect = CGRect(), style: DAMainLabelStyle = .xlarge) {
        // set the main label
        let topLabel = DAMainLabel(style: style, bold: true)
        topLabel.text = name
        topLabel.sizeToFit()
        
        // set the text label
        textLabel = DAMultiLineLabel(style: style.shrink())
        textLabel.insets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        super.init(topView: topLabel, subView: textLabel, expanded: false, frame: frame)
        
        // observer to follow the changes in the text label
        textLabel.addObserver(self, forKeyPath: "text", options: [.new], context: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        textLabel.removeObserver(self, forKeyPath: "text")
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            if textLabel.text == "" {
                self.removeFromSuperview()
            }
        }
    }
}
