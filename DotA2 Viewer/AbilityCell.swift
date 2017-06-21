//
//  HeroAbilityCell.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-08.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class AbilityCell: UITableViewCell {
    
    private static let padding: CGFloat = 8
    
    // MARK: Views
    private var nameLabel = UILabel()
    private var specialsLabel = UILabel()
    private var abilityImageView = UIImageView()
    private var descriptionLabel = UILabel()
    private var typeKVViews = [KeyValueView]()
    private var dataKVViews = [KeyValueView]()
    private var modifierLabels = [UILabel]()
    private var cooldownView = KeyValueView()
    private var manaView = KeyValueView()
    private var notesLabel = UILabel()
    
    // MARK: - Variables.
    public var name: String? {
        didSet {
            nameLabel.text = name
            
            setNeedsLayout()
        }
    }
    public var specials: NSAttributedString? {
        didSet {
            specialsLabel.attributedText = specials
            
            setNeedsLayout()
        }
    }
    public var abilityImage: UIImage? {
        didSet {
            abilityImageView.image = abilityImage
            
            setNeedsLayout()
        }
    }
    public var types: [ModifiableValue]? {
        didSet {
           configure(kvViews: &typeKVViews, values: types, orientation: .vertical)
            
            setNeedsLayout()
        }
    }
    public var abilityDescription: String? {
        didSet {
            descriptionLabel.text = abilityDescription
            
            setNeedsLayout()
        }
    }
    public var data: [ModifiableValue]? {
        didSet {
            configure(kvViews: &dataKVViews, values: data, orientation: .horizontal)
            
            setNeedsLayout()
        }
    }
    public var modifiers: [Modifier]? {
        didSet {
            configure(labels: &modifierLabels, modifiers: modifiers)
            
            setNeedsLayout()
        }
    }
    public var cooldown: ModifiableValue? {
        didSet {
            cooldownView.clear()
            
            guard let cooldown = cooldown else {
                return
            }
            
            write(modifiableValue: cooldown, to: cooldownView)
            
            setNeedsLayout()
        }
    }
    public var mana: ModifiableValue? {
        didSet {
            manaView.clear()
            
            guard let mana = mana else {
                return
            }
            
            write(modifiableValue: mana, to: manaView)
            
            setNeedsLayout()
        }
    }
    public var notes: [Note]? {
        didSet {
            notesLabel.attributedText = nil
            
            guard let notes = notes else {
                return
            }
            
            let finalString = NSMutableAttributedString()
            for i in 0..<notes.count {
                if i != 0 {
                    finalString.append(NSAttributedString.uti_newLine)
                }
                finalString.append(notes[i].prettify())
            }

            notesLabel.attributedText = finalString

            setNeedsLayout()
        }
    }
    private(set) var preferredHeight: CGFloat = 44
    
    // MARK: - Initializers.
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        self.isUserInteractionEnabled = false
        
        // TODO: Add some of these fonts as defaults for label subclasses.
        nameLabel.font = Fonts.title
        abilityImageView.contentMode = .scaleAspectFit
        descriptionLabel.numberOfLines = 0
        cooldownView.orientation = .horizontal
        manaView.orientation = .horizontal
        notesLabel.numberOfLines = 0
        

        addSubview(nameLabel)
        addSubview(specialsLabel)
        addSubview(abilityImageView)
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(specialsLabel)
//        contentView.addSubview(abilityImageView)
//        contentView.addSubview(descriptionLabel)
//        contentView.uti_addSubviews(typeKVViews)
//        contentView.uti_addSubviews(dataKVViews)
//        contentView.uti_addSubviews(modifierLabels)
//        contentView.addSubview(cooldownView)
//        contentView.addSubview(manaView)
//        contentView.addSubview(notesLabel)
    }
    
    // MARK: - Custom functions.
    private func configure(kvViews: inout [KeyValueView], values: [ModifiableValue]?, orientation: KeyValueView.Orientation) {
        kvViews.forEach({ $0.clear() })
        
        guard let values = values else {
            return
        }
        
        let newKVViewCount = values.count - kvViews.count
        if newKVViewCount > 0 {
            for _ in 0..<newKVViewCount {
                let view = KeyValueView()
                view.orientation = orientation
                kvViews.append(view)
            }
        }
        
        assert(values.count <= kvViews.count, "KVViews not configured properly")
        
        for index in 0..<values.count {
            write(modifiableValue: values[index], to: kvViews[index])
        }
    }
    
    private func configure(labels: inout [UILabel], modifiers: [Modifier]?) {
        labels.forEach({
            $0.text = nil
            $0.attributedText = nil
        })
        
        guard let modifiers = modifiers else {
            return
        }
        
        let newLabelsCount = modifiers.count - labels.count
        if newLabelsCount > 0 {
            for _ in 0..<newLabelsCount {
                let label = UILabel()
                label.numberOfLines = 0
                labels.append(label)
            }
        }
        
        assert(modifiers.count <= labels.count, "Labels not configured properly")
        
        for index in 0..<modifiers.count {
            let label = labels[index]
            let modifier = modifiers[index]
            label.text = modifier.value
            label.textColor = modifier.getUIColour
        }
    }
    
    private func write(modifiableValue: ModifiableValue, to kvView: KeyValueView) {
        kvView.keyLabel.attributedText = NSAttributedString(string: modifiableValue.name,
                                                            attributes: Fonts.boldLabelAttribute)
        kvView.valueLabel.attributedText = modifiableValue.getValuesAttributedString()
    }
    
    // MARK: - Layout.
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var latestY: CGFloat = AbilityCell.padding
        let fullWidth = self.bounds.width - (2 * AbilityCell.padding)
        
        // Configure top line.
        specialsLabel.preferredMaxLayoutWidth = fullWidth / 2
        specialsLabel.sizeToFit()
        nameLabel.preferredMaxLayoutWidth = fullWidth - specialsLabel.bounds.width
        nameLabel.sizeToFit()
        let specialsFrame = specialsLabel.bounds
        let topLabelHeight = max(nameLabel.bounds.height, specialsFrame.height)
        specialsLabel.frame =  CGRect(x: self.bounds.width - specialsFrame.width - AbilityCell.padding,
                                     y: latestY,
                                     width: specialsFrame.width,
                                     height: topLabelHeight)
        nameLabel.frame = CGRect(x: AbilityCell.padding,
                                 y: latestY,
                                 width: self.bounds.width - (2 * AbilityCell.padding) - specialsFrame.width,
                                 height: topLabelHeight)
        latestY += (topLabelHeight + AbilityCell.padding)
        
        // Configure image.
        abilityImageView.sizeToFit()
        abilityImageView.frame = CGRect(x: AbilityCell.padding,
                                        y: latestY,
                                        width: self.bounds.width - (2 * AbilityCell.padding),
                                        height: abilityImageView.bounds.height)
        latestY += (abilityImageView.bounds.height + AbilityCell.padding)
        
        // Types
//        for typeView in typeKVViews {
//            if typeView.isEmpty {
//                break
//            }
//            
//            typeView.sizeToFit()
//            typeView.frame = CGRect(x: AbilityCell.padding, y: latestY, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
//        }
        
        preferredHeight = latestY
        
    }
    
    // This function size to fits all the labels. This is used for the height since the width is configured elsewhere
    private func sizeToFitViews() {
        nameLabel.sizeToFit()
        specialsLabel.sizeToFit()
        descriptionLabel.sizeToFit()
        typeKVViews.forEach({ $0.sizeToFit() })
        dataKVViews.forEach({ $0.sizeToFit() })
        modifierLabels.forEach({ $0.sizeToFit() })
        cooldownView.sizeToFit()
        manaView.sizeToFit()
        notesLabel.sizeToFit()
    }
}
