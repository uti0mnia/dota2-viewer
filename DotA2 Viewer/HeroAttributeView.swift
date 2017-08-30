//
//  HeroAttributeCell.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-13.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class HeroAttributeView: UIView {
    
    private static let sliderPadding: CGFloat = 20
    
    private static let strengthName = "strength.png"
    private static let strengthPrimaryName = "strength_primary.png"
    private static let agilityName = "agility.png"
    private static let agilityPrimaryName = "agility_primary.png"
    private static let intelligenceName = "intelligence.png"
    private static let intelligencePrimaryName = "intelligence_primary.png"
    
    weak var delegate: HeroAttributeViewDelegate?
    
    private(set) var levelLabel = DALabel(style: .subtitle)
    
    private var slider = HeroAttributeSlider()
    private var oldSliderValue = 0
    
    private(set) var strengthLabel = DALabel(style: .text)
    private(set) var agilityLabel = DALabel(style: .text)
    private(set) var intelligenceLabel = DALabel(style: .text)
    
    private var strengthIV = UIImageView()
    private var agilityIV = UIImageView()
    private var intelligenceIV = UIImageView()
    
    private var topStackView: UIStackView = {
        let sv = UIStackView()
        
        sv.alignment = .fill
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        initView()
        
        strengthLabel.textAlignment = .center
        agilityLabel.textAlignment = .center
        intelligenceLabel.textAlignment = .center
        
        let strengthSV = UIStackView(arrangedSubviews: [strengthIV, strengthLabel])
        strengthSV.axis = .vertical
        let agilitySV = UIStackView(arrangedSubviews: [agilityIV, agilityLabel])
        agilitySV.axis = .vertical
        let intelligenceSV = UIStackView(arrangedSubviews: [intelligenceIV, intelligenceLabel])
        intelligenceSV.axis = .vertical
        
        topStackView.u0_addArrangedSubviews(views: [strengthSV, agilitySV, intelligenceSV])
        self.u0_addSubviews([levelLabel, topStackView, slider])
        
        addConstraints()
    }
    
    private func initView() {
        levelLabel.textAlignment = .center
        
        strengthIV.contentMode = .center
        agilityIV.contentMode = .center
        intelligenceIV.contentMode = .center
        
        resetAttributeImages()
        
        slider.addTarget(self, action: #selector(sliderDidChangeValue), for: .valueChanged)
    }
    
    private func resetAttributeImages() {
        strengthIV.image = UIImage(named: HeroAttributeView.strengthName)
        agilityIV.image = UIImage(named: HeroAttributeView.agilityName)
        intelligenceIV.image = UIImage(named: HeroAttributeView.intelligenceName)
    }
    
    private func addConstraints() {
        levelLabel.snp.makeConstraints() { make in
            make.left.top.right.equalTo(self).inset(Layout.defaultPadding).priority(UILayoutPriorityDefaultHigh)
            
        }
        topStackView.snp.makeConstraints() { make in
            make.top.equalTo(levelLabel.snp.bottom).offset(Layout.defaultPadding)
            make.left.right.equalTo(self).inset(Layout.defaultPadding).priority(UILayoutPriorityDefaultHigh)
            make.bottom.equalTo(slider.snp.top).offset(-Layout.defaultPadding)
        }
        
        slider.snp.makeConstraints() { make in
            make.left.right.equalTo(self).inset(HeroAttributeView.sliderPadding).priority(UILayoutPriorityDefaultHigh)
            make.bottom.equalTo(self).inset(Layout.defaultPadding).priority(UILayoutPriorityDefaultHigh)
        }
    }
    
    public func setPrimaryAttribute(_ attribute: HeroAttribute) {
        resetAttributeImages()
        
        switch attribute {
        case .agility:
            agilityIV.image = UIImage(named: HeroAttributeView.agilityPrimaryName)
        case .intelligence:
            intelligenceIV.image = UIImage(named: HeroAttributeView.intelligencePrimaryName)
        case .strength:
            strengthIV.image = UIImage(named: HeroAttributeView.strengthPrimaryName)
            
        }
    }
    
    public func resetSlider(animated: Bool) {
        slider.setValue(0, animated: animated)
    }
    
    @objc func sliderDidChangeValue() {
        let newValue = Int(slider.value + 0.5)
        slider.setValue(Float(newValue), animated: false)
        
        if newValue != oldSliderValue {
            oldSliderValue = newValue
            delegate?.heroAttributeView(self, sliderDidChangeValue: newValue)
        }
    }
    
}
