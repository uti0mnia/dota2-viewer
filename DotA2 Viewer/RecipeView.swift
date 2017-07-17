//
//  ImteBuildView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-25.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class RecipeView: UIView {
    
    public var item: Item? {
        didSet {
            guard let item = item else {
                return
            }
            
            let buildsInto = item.buildsInto?.allObjects as? [ArrayItem]
            buildsIntoView.itemNames = buildsInto?.map({ $0.value })
            
            let buildsFrom = item.buildsFrom?.allObjects as? [ArrayItem]
            buildsFromView.itemNames = buildsFrom?.map({ $0.value })
        }
    }
    
    private(set) var buildsIntoView = RecipeBuildView()
    private(set) var buildsFromView = RecipeBuildView()
    
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
            make.left.top.right.equalTo(self).inset(Layout.defaultPadding)
            make.bottom.equalTo(buildsFromView.snp.top).offset(-Layout.defaultPadding)
        }
        
        buildsFromView.snp.makeConstraints() { make in
            make.left.bottom.right.equalTo(self).inset(Layout.defaultPadding)
        }
    }
}
