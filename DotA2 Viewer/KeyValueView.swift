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
    
    private(set) var keyLabel = UILabel()
    private(set) var valueLabel = UILabel()
    private var stackView: UIStackView = {
        let sv = UIStackView()
        
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    public var isVertical = false {
        didSet {
            stackView.axis = isVertical ? .vertical : .horizontal
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
        valueLabel.setContentHuggingPriority(251, for: .horizontal)
        valueLabel.setContentHuggingPriority(251, for: .vertical)
        
        addSubview(stackView)
        stackView.uti_addArrangedSubviews(views: [keyLabel, valueLabel])
        stackView.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalTo(self).priority(999)
        }
    }
    
    public func clear() {
        keyLabel.text = nil
        valueLabel.text = nil
    }
    
}
