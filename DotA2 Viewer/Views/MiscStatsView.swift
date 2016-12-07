//
//  MiscStatsView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-03.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class MiscStatsView: UIView {
    // MARK - Outlets
    @IBOutlet weak var attackAnimationLabel: UILabel!
    @IBOutlet weak var attackRangeLabel: UILabel!
    @IBOutlet weak var moveSpeedLabel: UILabel!
    @IBOutlet weak var projectileSpeedLabel: UILabel!
    @IBOutlet weak var collisionSizeLabel: UILabel!
    @IBOutlet weak var magicResistanceLabel: UILabel!
    @IBOutlet weak var turnRateLabel: UILabel!
    @IBOutlet weak var visionLabel: UILabel!
    
    
    // MARK - Properties
    fileprivate let nibName = "MiscStatsView"
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
