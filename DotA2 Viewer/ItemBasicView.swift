//
//  HeroBasicView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-27.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class ItemBasicView: UIView {
    
    private static let padding: CGFloat = 8
    
    private var costLabel = UILabel()
    private var availabilityLabel = UILabel()
    private var typeImageView = UIImageView()
    private var typeLabel = UILabel()
    private var detailStack = UIStackView()
    private var detailViews = [KeyValueView]()
    private var additionalInfoLabel = UILabel()
    private var recipeView = RecipeView()
    private var loreLabel = UILabel()
    
    public var item: Item? {
        didSet {
            guard let item = item else {
                return
            }
            
            let costString = "Cost: \(item.cost.uti_string(0))"
            costLabel.text = item.recipeCost == 0 ? costString : costString + " (\(item.recipeCost.uti_string(0)))"
            availabilityLabel.attributedText = item.availabilityAttributedString
            typeImageView.image = UIImage(named: item.type)
            typeLabel.text = item.type
            set(details: item.details)
            
            if let additionalInfoNotes = item.additionalInfo?.array as? [Note] {
                let finalString = Note.prettify(additionalInfoNotes)
                additionalInfoLabel.attributedText = finalString
            }
            
            recipeView.item = item
            loreLabel.text = item.lore
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
        availabilityLabel.textAlignment = .right
        typeImageView.contentMode = .scaleAspectFit
        typeImageView.setContentHuggingPriority(251, for: .horizontal)
        detailStack.axis = .vertical
        detailStack.distribution = .fillProportionally
        additionalInfoLabel.numberOfLines = 0
        loreLabel.numberOfLines = 0
        
        addSubview(costLabel)
        addSubview(availabilityLabel)
        addSubview(detailStack)
        addSubview(additionalInfoLabel)
        addSubview(recipeView)
        addSubview(loreLabel)
        
        addConstraints()
    }
    private func addConstraints() {
        let padding = ItemBasicView.padding
        
        let typeStack = UIStackView(arrangedSubviews: [typeImageView, typeLabel])
        typeStack.alignment = .top
        typeStack.distribution = .fillProportionally
        addSubview(typeStack)
        
        costLabel.snp.makeConstraints() { make in
            make.left.top.equalTo(self).inset(padding)
            make.right.lessThanOrEqualTo(availabilityLabel.snp.left).offset(-padding)
            make.bottom.equalTo(availabilityLabel.snp.bottom)
            make.height.equalTo(costLabel.font.pointSize)
        }
        
        availabilityLabel.snp.makeConstraints() { make in
            make.top.right.equalTo(self).inset(padding)
        }
        
        typeStack.snp.makeConstraints() { make in
            make.left.right.equalTo(self).inset(padding)
            make.top.equalTo(costLabel.snp.bottom).offset(padding)
        }
        
        detailStack.snp.makeConstraints() { make in
            make.left.right.equalTo(self).inset(padding)
            make.top.equalTo(typeStack.snp.bottom).offset(padding)
        }
        
        additionalInfoLabel.snp.makeConstraints() { make in
            make.left.right.equalTo(self).inset(padding)
            make.top.equalTo(detailStack.snp.bottom).offset(padding)
        }
        
        recipeView.snp.makeConstraints() { make in
            make.left.right.equalTo(self).inset(padding)
            make.top.equalTo(additionalInfoLabel.snp.bottom).offset(padding)
        }
        
        loreLabel.snp.makeConstraints() { make in
            make.left.bottom.right.equalTo(self).inset(padding)
            make.top.equalTo(recipeView.snp.bottom).offset(padding)
        }
        
    }
    
    public func setDelegateForRecipeView(_ delegate: RecipeBuildViewDelegate) {
        recipeView.buildsFromView.delegate = delegate
        recipeView.buildsIntoView.delegate = delegate
    }
    
    private func set(details: [String: [String]]) {
        detailViews.forEach({ $0.removeFromSuperview() })
        
        let keys = Array(details.keys)
        for index in 0..<keys.count {
            if index >= detailViews.count {
                detailViews.append(KeyValueView())
            }
            
            let key = keys[index]
            let value = details[key]
            let view = detailViews[index]
            
            view.keyLabel.text = key
            view.valueLabel.text = value?.joined(separator: "\n")
            
            detailStack.addArrangedSubview(view)
            
        }
    }

}
