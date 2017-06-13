//
//  KeyValueView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-01.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class KeyValueView: UIView {
    public enum KeyValueViewOrientation {
        case vertical, horizontal
    }
    private(set) var keyLabel = UILabel()
    private(set) var valueLabel = UILabel()
    private var stackView: UIStackView = {
        let sv = UIStackView()
        
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        
        sv.isLayoutMarginsRelativeArrangement = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    public var orientation: KeyValueViewOrientation = .vertical {
        didSet {
            switch orientation {
            case .horizontal:
                keyLabel.textAlignment = .left
                valueLabel.textAlignment = .right
                stackView.axis = .horizontal
            case .vertical:
                keyLabel.textAlignment = .center
                valueLabel.textAlignment = .center
                stackView.axis = .vertical
            }
        }
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
        self.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        stackView.addArrangedSubviews(views: [keyLabel, valueLabel])
    }
}
