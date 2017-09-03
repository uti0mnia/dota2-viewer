//
//  HeroAbilityView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-08.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class AbilityView: UIView, AbilitySpecialViewDelegate {
    
    public weak var delegate: AbilityViewDelegate?
    
    private var nameLabel = DALabel(style: .title)
    private var specialsView = AbilitySpecialView()
    private(set) var abilityImageView = UIImageView() {
        didSet {
            if abilityImageView.image == nil {
                abilityImageView.removeFromSuperview()
            } else if abilityImageView.superview == nil {
                imageStackView.insertArrangedSubview(abilityImageView, at: 0)
            }
        }
    }
    private var descriptionView: DASeparatedView = {
        let view = DASeparatedView()
        view.titleLabel.text = "Description"
        let label = DALabel(style: .text)
        label.numberOfLines = 0
        view.setContentView(label)
        return view
    }()
    
    // This is for the stack view that holds the ability image and the TypeStackView.
    // God I need to get better with names.
    private var imageSeparatedView = DASeparatedView()
    private var imageStackView = UIStackView()
    private var typeStackView: TypeKVStackView = {
        let sv = TypeKVStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.spacing = Layout.defaultPadding
        return sv
    }()
    private var dataStackView: DataKVStackView = {
        let sv = DataKVStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.spacing = Layout.defaultPadding
        return sv
    }()
    
    private var modifierStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.spacing = Layout.defaultPadding
        return sv
    }()
    private var modifierLabels = [DALabel]()
    
    private var bottomStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.spacing = Layout.defaultPadding
        return sv
    }()
    private var cooldownView = KeyValueView()
    private var manaView = KeyValueView()
    private var notesLabel = DALabel(style: .text)
    
    private lazy var manaAttributedString: NSAttributedString = {
        let finalString = NSMutableAttributedString(string: "Mana", attributes: [NSFontAttributeName: Fonts.text.bold])
        return finalString
    }()
    private lazy var cooldownAttributedString: NSAttributedString = {
        let finalString = NSMutableAttributedString(string: "Cooldown", attributes: [NSFontAttributeName: Fonts.text.bold])
        return finalString
    }()
    
    public var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    public var specials: [String]? {
        didSet {
            specialsView.setSpecials(specials)
        }
    }
    public var types: [ModifiableValue]? {
        didSet {
           typeStackView.values = types
        }
    }
    public var abilityDescription: String? {
        didSet {
            let view = descriptionView.currentContentView
            
            assert(view is DALabel, "Description subview isn't a DALbel.")
            
            if let label = view as? DALabel {
                label.text = abilityDescription
            }
            
            updateConstraints()
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
                    let label = DALabel(style: .text)
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
            
            cooldownView.keyLabel.attributedText = cooldownAttributedString
            cooldownView.valueLabel.attributedText = cooldown.getValuesAttributedString()
            bottomStackView.insertArrangedSubview(cooldownView, at: 0)
        }
    }
    public var mana: ModifiableValue? {
        didSet {
            manaView.removeFromSuperview()
            
            guard let mana = mana else {
                return
            }
            
            manaView.keyLabel.attributedText = manaAttributedString
            manaView.valueLabel.attributedText = mana.getValuesAttributedString()
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
        
        nameLabel.font = Fonts.title
        
        specialsView.delegate = self
        
        abilityImageView.contentMode = .scaleAspectFit
        abilityImageView.clipsToBounds = true
        abilityImageView.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        
        imageStackView.u0_addArrangedSubviews(views: [abilityImageView, typeStackView])
        imageStackView.alignment = .center
        imageStackView.spacing = Layout.defaultPadding
        imageSeparatedView.setContentView(imageStackView)
        
        cooldownView.isVertical = false
        cooldownView.valueLabel.textAlignment = .right
        
        manaView.isVertical = false
        manaView.valueLabel.textAlignment = .right
        
        bottomStackView.addArrangedSubview(DASeparatorView())
        
        notesLabel.numberOfLines = 0
        
        addSubview(nameLabel)
        addSubview(specialsView)
        addSubview(imageSeparatedView)
        addSubview(descriptionView)
        addSubview(dataStackView)
        addSubview(modifierStackView)
        addSubview(bottomStackView)
        
        addConstraints()
    }
    
    private func addConstraints() {
        let padding = Layout.defaultPadding
        
        nameLabel.snp.makeConstraints() { make in
            make.left.top.equalTo(self).inset(padding)
            make.bottom.equalTo(specialsView)
            make.height.equalTo(nameLabel.font.pointSize)
        }
        
        specialsView.snp.makeConstraints() { make in
            make.top.right.equalTo(self).inset(padding)
            make.left.equalTo(nameLabel.snp.right).offset(padding)
        }
        
        imageSeparatedView.snp.makeConstraints() { make in
            make.left.right.equalTo(self).inset(padding)
            make.top.equalTo(nameLabel.snp.bottom).offset(padding)
        }
        
        descriptionView.snp.makeConstraints() { make in
            make.top.equalTo(imageSeparatedView.snp.bottom).offset(padding)
            make.left.right.equalTo(self).inset(padding)
        }
        
        dataStackView.snp.makeConstraints() { make in
            make.top.equalTo(descriptionView.snp.bottom).offset(padding)
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
    
    // MARK: - AbilitySpecialViewDelegate
    
    func abilitySpecialView(_ abilitySpecialView: AbilitySpecialView, didTapOnSpecial special: String) {
        delegate?.abilityView(self, didTapOnSpecial: special)
    }
}
