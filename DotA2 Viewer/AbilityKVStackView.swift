//
//  AbilityTypeStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-21.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class AbilityKVStackView: UIStackView {
    
    private var kvViews = [KeyValueView]()
    public var values: [ModifiableValue]? {
        didSet {
            kvViews.forEach({ $0.removeFromSuperview() })
            
            guard let values = values else {
                return
            }
            
            let newKVViewCount = values.count - kvViews.count
            if newKVViewCount > 0 {
                for _ in 0..<newKVViewCount {
                    kvViews.append(createKVView())
                }
            }
            
            assert(values.count <= kvViews.count, "KVViews not configured properly")
            
            for index in 0..<values.count {
                let view = kvViews[index]
                write(modifiableValue: values[index], to: view)
                self.addArrangedSubview(view)
            }
            
        }
    }
    
    public func createKVView() -> KeyValueView {
        assertionFailure("This needs to be overridden in a subclass")
        return KeyValueView()
    }
    
    private func write(modifiableValue: ModifiableValue, to kvView: KeyValueView) {
        kvView.keyLabel.text = modifiableValue.name
        kvView.valueLabel.attributedText = modifiableValue.getValuesAttributedString()
    }
    
}

class TypeKVStackView: AbilityKVStackView {
    override func createKVView() -> KeyValueView {
        let view = KeyValueView()
        view.isVertical = true
        view.keyLabel.textAlignment = .left
        view.valueLabel.textAlignment = .left
        return view
    }
}

class DataKVStackView: AbilityKVStackView {
    override func createKVView() -> KeyValueView {
        let view = KeyValueView()
        view.keyLabel.textAlignment = .left
        view.valueLabel.textAlignment = .right
        return view
    }
}
