//
//  BaseStatsView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-03.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class BaseStatsView: UIView {
    // MARK - Outlets
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var attackPerSLabel: UILabel!
    @IBOutlet weak var armorLabel: UILabel!
    @IBOutlet weak var spellDmgLabel: UILabel!
    
    
    // MARK - Properties
    fileprivate let nibName = "BaseStatsView"
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
        
        // set the hp/mana label layers
        hpLabel.layer.cornerRadius = 10
        manaLabel.layer.cornerRadius = 10
    }

}
