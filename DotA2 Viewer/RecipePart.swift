//
//  ItemImageView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-27.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class RecipePart: UIImageView {
    public var itemName: String? {
        didSet {
            guard let itemName = itemName else {
                return
            }
            
            self.image = UIImage(named: Item.imageNameFrom(itemName))
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
    }
    
}
