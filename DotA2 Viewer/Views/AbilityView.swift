//
//  AbilityView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-03.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class AbilityView: UIView {
    // MARK - Outlets
    @IBOutlet weak var topStack: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cooldown: ImageLabelView!
    @IBOutlet weak var mana: ImageLabelView!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var modifiersLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var notesLabel: UILabel!
    
    
    // MARK - Properties
    fileprivate let nibName = "AbilityView"
    fileprivate var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        let bundle = Bundle(for: type(of: self))
        self.view = UINib(nibName: self.nibName, bundle: bundle).instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view.frame = bounds
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
}
