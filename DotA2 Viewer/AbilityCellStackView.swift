//
//  AbilityCellStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-01.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

// Variables to be set by each ability:
// - @param{types}: [ModifiableValue]?
// - @param{abilityDescription}: String?
// - @param{data}: [ModifiableValue]?
// - @param{modifiers}: [Modifier]?
// - @param{cooldown}: ModifiableValue?
// - @param{mana}: ModifiableValue?
// - @param{notes}: [Note]?
class AbilityCellStackView: UIStackView {
    
    private var descriptionIndex: Int {
        return 1
    }
    private var dataStackIndex: Int {
        return (abilityDescription == nil) ? 1 : 2
    }
    private var modifierIndex: Int {
        return data?.count ?? 0
    }
    private var cooldownIndex: Int {
        return dataStackIndex + 1
    }
    private var manaIndex: Int {
        return (cooldown == nil) ? dataStackIndex + 1 : cooldownIndex + 1
    }
    
    // 1 (holds types in horizontal stack)
    private var typeStack: UIStackView = {
        let sv = UIStackView()
        
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.alignment = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    // 2 (description of ability)
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    //3 (Holds Data, modifiers, cooldown, mana, notes)
    private var dataStack: UIStackView = {
        let sv = UIStackView()
        
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.alignment = .fill
        
        return sv
    }()
    private var modifierStack: UIStackView = {
        let sv = UIStackView()
        
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.alignment = .fill
        
        return sv
    }()
    
    // UI elements to display
    private var typeKVViews = [KeyValueView]()
    private var dataKVViews = [KeyValueView]()
    private var modifierKVViews = [UILabel]()
    private var cooldownView = KeyValueView()
    private var manaView = KeyValueView()
    private var notesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // Data to display
    public var types: [ModifiableValue]? {
        didSet {
            typeKVViews.forEach() { $0.clear() }
            
            guard let types = types else {
                return
            }
            
            // TODO: Potentially remove the need for typeKVViews
            // configure the type view array to hold enough views
            let newKVViewCount = types.count - typeKVViews.count
            if newKVViewCount > 0 {
                for _ in 0..<newKVViewCount {
                    let view = KeyValueView()
                    view.orientation = .horizontal
                    typeKVViews.append(view)
                    typeStack.addArrangedSubview(view)
                }
            }
            
            assert(types.count <= typeKVViews.count, "Type KVViews not configured properly")
            
            // configure each view
            print("Count: \(types.count)")
            for index in 0..<types.count {
                print("index: \(index)")
                let view = typeKVViews[index]
                configure(kvView: view, withModifiableValue: types[index])
                print(types[index].name)
            }
            print("-----------------------------------------------------")
        }
    }
    public var abilityDescription: String? {
        didSet {
//            descriptionLabel.removeFromSuperview()
            
            descriptionLabel.text = abilityDescription
//            self.insertArrangedSubview(descriptionLabel, at: descriptionIndex)
        }
    }
    public var data: [ModifiableValue]? {
        didSet {
//            dataKVViews.forEach() {
//                if $0.superview != nil {
//                    $0.removeFromSuperview()
//                }
//            }
            
//            guard let data = data else {
//                return
//            }
//            
//            // configure the data view array to hold enough views
//            let newKVViewCount = data.count - dataKVViews.count
//            if newKVViewCount > 0 {
//                for _ in 0..<newKVViewCount {
//                    let view = KeyValueView()
//                    view.orientation = .horizontal
//                    dataKVViews.append(view)
//                }
//            }
//            
//            assert(data.count <= dataKVViews.count, "Data KVViews not configured properly")
//            
//            // configure each view
//            for index in 0..<data.count {
//                let view = dataKVViews[index]
//                configure(kvView: view, withModifiableValue: data[index])
//                dataStack.insertArrangedSubview(view, at: index)
//            }
        }
    }
    public var modifiers: [Modifier]? {
        didSet {
//            modifierStack.subviews.forEach() { $0.removeFromSuperview() }
//            
//            guard let modifiers = modifiers else {
//                return
//            }
//            
//            // configure the data view array to hold enough views
//            let newKVViewCount = modifiers.count - modifierKVViews.count
//            if newKVViewCount > 0 {
//                for _ in 0..<newKVViewCount {
//                    let label = UILabel()
//                    label.numberOfLines = 0
//                    modifierKVViews.append(label)
//                }
//            }
//            
//            assert(modifiers.count <= modifierKVViews.count, "Modifier KVViews not configured properly")
//            
//            // configure each view
//            for index in 0..<modifiers.count {
//                let label = modifierKVViews[index]
//                let modifier = modifiers[index]
//                label.text = modifier.value
//                label.textColor = modifier.getUIColour
//                modifierStack.addArrangedSubview(label)
//            }
        }
    }
    public var cooldown: ModifiableValue? {
        didSet {
//            cooldownView.removeFromSuperview()
            
//            guard let cooldown = cooldown else {
//                return
//            }
//            
//            configure(kvView: cooldownView, withModifiableValue: cooldown)
//            
//            self.insertArrangedSubview(cooldownView, at: cooldownIndex)
//            
        }
    }
    public var mana: ModifiableValue? {
        didSet {
//            manaView.removeFromSuperview()
            
//            guard let mana = mana else {
//                return
//            }
//            
//            configure(kvView: manaView, withModifiableValue: mana)
//            
//            self.insertArrangedSubview(manaView, at: manaIndex)
        }
    }
    public var notes: [Note]? {
        didSet {
//            notesLabel.removeFromSuperview()
            
//            guard let notes = notes else {
//                return
//            }
//            
//            let finalString = NSMutableAttributedString()
//            for i in 0..<notes.count {
//                if i != 0 {
//                    finalString.append(NSAttributedString.newLine)
//                }
//                finalString.append(notes[i].prettify())
//            }
//            
//            notesLabel.attributedText = finalString
//            
//            self.addArrangedSubview(notesLabel) // add to end
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        // setup properties
        self.axis = .vertical
        self.distribution = .fillProportionally
        self.alignment = .fill
        
        self.uti_addArrangedSubviews(views: [typeStack, descriptionLabel, dataStack, modifierStack, cooldownView, manaView, notesLabel])
    }
    
    private func configure(kvView view: KeyValueView, withModifiableValue value: ModifiableValue) {
        view.keyLabel.attributedText = NSAttributedString(string: value.name, attributes: Fonts.boldLabelAttribute)
        view.valueLabel.attributedText = value.getValuesAttributedString()
    }
    
    
}
