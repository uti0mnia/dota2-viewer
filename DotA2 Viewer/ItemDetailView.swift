//
//  ItemDetailView.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-20.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class ItemDetailView: UIView {
    /* Properties */
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var recipeStack: UIStackView!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var cooldownLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var loreLabel: UILabel!
    
    
    override init(frame: CGRect) {
        // init the frame
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refineView() {
        // meant to remove items from the view if they're empty
        if recipeStack.subviews.count < 1 { recipeStack.removeFromSuperview() }
        if manaLabel.text == nil { manaLabel.removeFromSuperview() }
        if cooldownLabel.text == nil { cooldownLabel.removeFromSuperview() }
        
    }
    
    
    
}











