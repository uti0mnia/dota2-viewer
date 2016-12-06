//
//  HeroView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-03.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroView: UIView {
    // MARK - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var attackTypeLabel: UILabel!
    @IBOutlet weak var rolesLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var attribute1View: AttributeView!
    @IBOutlet weak var attribute2View: AttributeView!
    @IBOutlet weak var attribute3View: AttributeView!
    @IBOutlet weak var baseStatsView: BaseStatsView!
    @IBOutlet weak var miscStatsView: MiscStatsView!
    
    
    // MARK - Properties
    fileprivate let nibName = "HeroView"
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
