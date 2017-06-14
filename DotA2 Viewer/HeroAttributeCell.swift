//
//  HeroAttributeCell.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-13.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class HeroAttributeCell: UITableViewCell {
    public static let nibName = "HeroAttributeCell"
    
    weak var delegate: HeroAttributeViewDelegate?
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var agilityLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    
    @IBOutlet weak private var strengthIV: UIImageView!
    @IBOutlet weak private var agilityIV: UIImageView!
    @IBOutlet weak private var intelligenceIV: UIImageView!
    
    private var primaryAttributeLayer: CALayer!
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        commonInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//        commonInit()
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }
    
    private func commonInit() {
        slider.addTarget(self, action: #selector(sliderDidChangeValue), for: .valueChanged)
        
        primaryAttributeLayer = CAShapeLayer()
        primaryAttributeLayer.backgroundColor = UIColor.clear.cgColor
        primaryAttributeLayer.frame = strengthIV.frame
        primaryAttributeLayer.borderWidth = 3
        primaryAttributeLayer.borderColor = UIColor.yellow.cgColor      // change to gold
    }
    
    public func setPrimaryAttribute(_ attribute: HeroAttribute) {
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
        delegate?.sliderDidChangeValue(Int(slider.value))
    }
    
}
