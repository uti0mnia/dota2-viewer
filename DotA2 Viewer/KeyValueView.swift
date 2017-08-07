//
//  KeyValueView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-01.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class KeyValueView: UIView {
    
    private(set) var keyLabel = DALabel(style: .text)
    private(set) var valueLabel = DALabel(style: .text)
    
    public var isVertical = false {
        didSet {
            if isVertical {
                setVerticalConstraints()
            } else{
                setHorizontalConstraints()
            }
        }
    }
    
    public var isEmpty: Bool {
        return keyLabel.text == nil && valueLabel.text == nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        keyLabel.numberOfLines = 0
        valueLabel.numberOfLines = 0
        
        addSubview(keyLabel)
        addSubview(valueLabel)
        
        keyLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)
        setHorizontalConstraints()
    }
    
    private func setVerticalConstraints() {
        keyLabel.snp.removeConstraints()
        valueLabel.snp.removeConstraints()
        
        keyLabel.snp.makeConstraints() { make in
            make.left.top.right.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints() { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(keyLabel.snp.bottom)
        }
    }
    
    private func setHorizontalConstraints() {
        keyLabel.snp.removeConstraints()
        valueLabel.snp.removeConstraints()
        
        keyLabel.snp.makeConstraints() { make in
            make.left.top.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.right.lessThanOrEqualTo(valueLabel.snp.left).offset(-Layout.defaultPadding)
        }
        
        valueLabel.snp.makeConstraints() { make in
            make.top.right.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    public func clear() {
        keyLabel.text = nil
        valueLabel.text = nil
    }
    
}
