//
//  ItemImageView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-27.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class RecipePart: UIImageView {
    
    private static let borderWidth: CGFloat = 1
    
    public var itemName: String? {
        didSet {
            guard let itemName = itemName else {
                return
            }
            
            self.image = UIImage(named: Item.thumbnailImageNameFrom(itemName))
        }
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
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
        contentMode = .scaleAspectFit
        layer.cornerRadius = Layout.roundedRectangleRadius
        
        // layer.borderColor = Colours.secondaryColour.cgColor
        // layer.borderWidth = RecipePart.borderWidth
    }
    
}
