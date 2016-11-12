//
//  AttributeStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-11-11.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import ChameleonFramework



class AttributesStackView: UIStackView {
    
    class AttributeStackView: UIStackView {
        
        var name: String { get { return attribute.name } }
        var base: Double { get { return attribute.base as Double} }
        var increment: Double { get { return attribute.increment as Double } }
        private var attribute: Attribute!
        private var valueLabel: DAMainLabel!
        
        init(attribute: Attribute, isPrimary: Bool) {
            // set property
            self.attribute = attribute
            
            super.init(frame: CGRect())
            
            // create the image
            var image: UIImage!
            switch attribute.name {
            case "Strength":
                image = #imageLiteral(resourceName: "strength_icon.png")
            case "Agility":
                image = #imageLiteral(resourceName: "agility_icon.png")
            default:
                image = #imageLiteral(resourceName: "intelligence_icon.png")
            }

            // configure the image view
            let frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            let imageView = UIImageView(frame: frame)
            imageView.image = image
            imageView.layer.cornerRadius = frame.height / 2 // make it a circle
            if isPrimary { // change the look if it's the primary attribute
                imageView.layer.borderWidth = 2
                imageView.layer.borderColor = UIColor.flatYellow().cgColor
            }

            // configure the label
            valueLabel = DAMainLabel()
            valueLabel.text = String(format: "%.0f", self.base + self.increment * 1.0)
            
            self.addArrangedSubview(imageView)
            self.addArrangedSubview(valueLabel)

            
            // properties
            self.axis = .horizontal
            self.alignment = .fill
            self.distribution = .fillProportionally
            self.spacing = 12
            

        }
        
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setValue(forLevel level: Int) {
            // make sure legal level
            guard level >= 1 && level <= 25 else {
                return
            }
            
            valueLabel.text = String(format: "%.0f", base + increment * Double(level-1))
        }
    }

    var intelligence: Attribute!
    var agility: Attribute!
    var strength: Attribute!
    private let space: CGFloat = 8
    
    init(frame: CGRect, attributeSet set: AttributeSet) {
        // properties
        self.intelligence = set.intelligence
        self.agility = set.agility
        self.strength = set.strength
        
        // parent init
        super.init(frame: frame)
        
        // create an attribute stack view for each attribute
        let intSV = AttributeStackView(attribute: set.intelligence, isPrimary: set.isPrimaryAttribute(name: .intelligence))
        let agiSV = AttributeStackView(attribute: set.agility, isPrimary: set.isPrimaryAttribute(name: .agility))
        let strSV = AttributeStackView(attribute: set.strength, isPrimary: set.isPrimaryAttribute(name: .strength))
        
        // add them to self
        self.addArrangedSubview(strSV)
        self.addArrangedSubview(agiSV)
        self.addArrangedSubview(intSV)
        
        // set properties
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .equalSpacing
        self.spacing = space
        
    }
    
    convenience init(attributeSet set: AttributeSet) {
        self.init(frame: CGRect(), attributeSet: set)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLevel(level: Int) {
        guard level >= 1 && level <= 25 else {
            return
        }
        
        // apply the new level value to each attribute
        for view in self.arrangedSubviews {
            // make sure it's an AttributeStackView
            guard let stack = view as? AttributeStackView else {
                continue
            }
            
            stack.setValue(forLevel: level)
            
        }
    }
    
}

































