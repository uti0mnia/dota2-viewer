//
//  ImteBuildView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-25.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class ItemRecipeView: UIView {
    
    public var item: Item? {
        didSet {
            guard let item = item else {
                return
            }
            
            buildsIntoView.imageNames = item.buildsInto?.allObjects as? [String]
            
            buildsFromView.imageNames = item.buildsFrom?.allObjects as? [String]
        }
    }
    
    private var buildsIntoView = ItemBuildView()
    private var buildsFromView = ItemBuildView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        addSubview(buildsIntoView)
        addSubview(buildsFromView)
        
        buildsIntoView.topLabelText = "Builds Into"
        buildsFromView.topLabelText = "Builds From"
        
        buildsIntoView.snp.makeConstraints() { make in
            make.left.top.right.equalTo(self).inset(8)
            make.bottom.equalTo(buildsFromView.snp.top).offset(-8)
        }
        
        buildsFromView.snp.makeConstraints() { make in
            make.left.bottom.right.equalTo(self).inset(8)
        }
    }
}
