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
    
    weak var delegate: HeroAttributeViewDelegate?
    
    private var slider: HeroAttributeSlider!
    private var oldSliderValue = 0
    
    private(set) var strengthLabel = DALabel(style: .text)
    private(set) var agilityLabel = DALabel(style: .text)
    private(set) var intelligenceLabel = DALabel(style: .text)
    
    private var strengthIV: UIImageView!
    private var agilityIV: UIImageView!
    private var intelligenceIV: UIImageView!
    
    private var topStackView: UIStackView = {
        let sv = UIStackView()
        
        sv.alignment = .fill
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        
        return sv
    }()
    
    private var primaryAttributeLayer: CALayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func initView() {
        strengthIV = createImageView()
        strengthIV.image = UIImage(named: "strength.png")
        
        agilityIV = createImageView()
        agilityIV.image = UIImage(named: "agility.png")
        
        intelligenceIV = createImageView()
        intelligenceIV.image = UIImage(named: "intelligence.png")
        
        slider = HeroAttributeSlider()
        slider.addTarget(self, action: #selector(sliderDidChangeValue), for: .valueChanged)
        
        primaryAttributeLayer = CAShapeLayer()
        primaryAttributeLayer.backgroundColor = UIColor.clear.cgColor
        primaryAttributeLayer.frame = strengthIV.frame
        primaryAttributeLayer.borderWidth = 3
        primaryAttributeLayer.borderColor = UIColor.yellow.cgColor      // TODO: Change to gold.
    }
    
    private func createImageView() -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .center
        return iv
    }
    
    private func addConstraints() {
        topStackView.snp.makeConstraints() { make in
            make.left.top.right.equalTo(self).inset(8).priority(999)
            make.bottom.equalTo(slider.snp.top).offset(-8)
        }
        
        slider.snp.makeConstraints() { make in
            make.left.bottom.right.equalTo(self).inset(8).priority(999)
        }
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
        self.u0_addSubviews([topStackView, slider])
        addConstraints()
    }
    
    
    public func setPrimaryAttribute(_ attribute: HeroAttribute?) {
        guard let attribute = attribute else {
            return
        }
        
        switch attribute {
        case .agility:
            addPrimaryAttributeMask(to: agilityIV)
        case .intelligence:
            addPrimaryAttributeMask(to: intelligenceIV)
        case .strength:
            addPrimaryAttributeMask(to: strengthIV)
        }
    }
    
    private func addPrimaryAttributeMask(to imageView: UIImageView) {
        primaryAttributeLayer.removeFromSuperlayer()
        imageView.layer.addSublayer(primaryAttributeLayer)
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
