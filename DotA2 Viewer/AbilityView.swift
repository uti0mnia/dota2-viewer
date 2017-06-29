//
//  HeroAbilityView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-08.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class AbilityView: UIView {
    
    private static let padding: CGFloat = 8
    
    // MARK: Views
    
    private var nameLabel = UILabel()
    private var specialsLabel = UILabel()
    private var abilityImageView = UIImageView()
    private var descriptionLabel = UILabel()
    
    private var imageStackView = UIStackView()
    private var typeStackView: TypeKVStackView = {
        let sv = TypeKVStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = AbilityView.padding
        return sv
    }()
    private var dataStackView: DataKVStackView = {
        let sv = DataKVStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.spacing = AbilityView.padding
        return sv
    }()
    
    private var modifierStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.spacing = AbilityView.padding
        return sv
    }()
    private var modifierLabels = [UILabel]()
    
    private var bottomStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.spacing = AbilityView.padding
        return sv
    }()
    private var cooldownView = KeyValueView()
    private var manaView = KeyValueView()
    private var notesLabel = UILabel()
    
    // MARK: - Variables
    
    public var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    public var specials: NSAttributedString? {
        didSet {
            specialsLabel.attributedText = specials
        }
    }
    public var abilityImage: UIImage? {
        didSet {
            abilityImageView.removeFromSuperview()
            
            abilityImageView.image = abilityImage
            
            if abilityImage != nil {
                imageStackView.insertArrangedSubview(abilityImageView, at: 0)
            }
        }
    }
    public var types: [ModifiableValue]? {
        didSet {
           typeStackView.values = types
        }
    }
    public var abilityDescription: String? {
        didSet {
            descriptionLabel.text = abilityDescription
        }
    }
    public var data: [ModifiableValue]? {
        didSet {
            dataStackView.values = data
        }
    }
    public var modifiers: [Modifier]? {
        didSet {
            modifierLabels.forEach({ $0.removeFromSuperview() })
            
            guard let modifiers = modifiers else {
                return
            }
            
            let newLabelsCount = modifiers.count - modifierLabels.count
            if newLabelsCount > 0 {
                for _ in 0..<newLabelsCount {
                    let label = UILabel()
                    label.numberOfLines = 0
                    modifierLabels.append(label)
                }
            }
            
            assert(modifiers.count <= modifierLabels.count, "Modifiers not configured properly")
            
            for index in 0..<modifiers.count {
                let label = modifierLabels[index]
                let modifier = modifiers[index]
                label.text = modifier.value
                label.textColor = modifier.getUIColour
            }
        }
    }
    public var cooldown: ModifiableValue? {
        didSet {
            cooldownView.removeFromSuperview()
            
            guard let cooldown = cooldown else {
                return
            }
            
            cooldown.write(to: cooldownView)
            bottomStackView.insertArrangedSubview(cooldownView, at: 0)
        }
    }
    public var mana: ModifiableValue? {
        didSet {
            manaView.removeFromSuperview()
            
            guard let mana = mana else {
                return
            }
            
            mana.write(to: manaView)
            let index = cooldownView.superview != nil ? 1 : 0
            bottomStackView.insertArrangedSubview(manaView, at: index)
        }
    }
    public var notes: [Note]? {
        didSet {
            notesLabel.attributedText = nil
            notesLabel.removeFromSuperview()
            
            guard let notes = notes else {
                return
            }
            
            let finalString = Note.prettify(notes)

            notesLabel.attributedText = finalString
            bottomStackView.addArrangedSubview(notesLabel)
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        abilityImageView.clipsToBounds = true
        
        imageStackView.uti_addArrangedSubviews(views: [abilityImageView, typeStackView])
        imageStackView.spacing = AbilityView.padding
        
        descriptionLabel.numberOfLines = 0
        
        cooldownView.isVertical = false
        
        manaView.isVertical = false
        
        notesLabel.numberOfLines = 0
        
        addSubview(nameLabel)
        addSubview(specialsLabel)
        addSubview(imageStackView)
        addSubview(descriptionLabel)
        addSubview(dataStackView)
        addSubview(modifierStackView)
        addSubview(bottomStackView)
        
        addConstraints()
    }
    
    private func addConstraints() {
        let padding = AbilityView.padding
        
        nameLabel.snp.makeConstraints() { make in
            make.left.top.equalTo(self).inset(padding)
            make.right.lessThanOrEqualTo(specialsLabel.snp.left).offset(-padding)
            make.bottom.equalTo(specialsLabel)
            make.height.equalTo(nameLabel.font.pointSize)
        }
        
        specialsLabel.snp.makeConstraints() { make in
            make.top.right.equalTo(self).inset(padding)
        }
        
        imageStackView.snp.makeConstraints() { make in
            make.left.right.equalTo(self).inset(padding)
            make.top.equalTo(nameLabel.snp.bottom).offset(padding)
        }
        
        descriptionLabel.snp.makeConstraints() { make in
            make.top.equalTo(imageStackView.snp.bottom).offset(padding)
            make.left.right.equalTo(self).inset(padding)
        }
        
        dataStackView.snp.makeConstraints() { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(padding)
            make.left.right.equalTo(self).inset(padding)
        }
        
        modifierStackView.snp.makeConstraints() { make in
            make.top.equalTo(dataStackView.snp.bottom).offset(padding)
            make.left.right.equalTo(self).inset(padding)
        }
        
        bottomStackView.snp.makeConstraints() { make in
            make.top.equalTo(modifierStackView.snp.bottom).offset(padding)
            make.left.right.bottom.equalTo(self).inset(padding)
        }
        
        
    }
}
