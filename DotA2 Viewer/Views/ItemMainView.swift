//
//  ItemView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class ItemMainView: UIView {
    // MARK - Oulets
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    
    
    // MARK - Properties
    fileprivate let nibName = "ItemMainView"
    fileprivate var view: UIView!
    
    override init(frame: CGRect = CGRect()) {
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
