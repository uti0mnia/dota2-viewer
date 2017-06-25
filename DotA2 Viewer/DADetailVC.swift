//
//  DetailVC.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DADetailVC: DAUIViewController {
    // MARK - Properties
    var object: Object!
    internal lazy var titleLabel: DAMainLabel = {[unowned self] in
        let lbl = DAMainLabel(style: .large)
        lbl.text = self.object.name
        lbl.sizeToFit()
        return lbl
    }()
    
    // MARK - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        guard object != nil else { return }
        addSubviews()
        setup()
    }
    
    internal func addSubviews() {
        // colours
        self.view.backgroundColor = UIColor.flatBlack()
    }
    
    internal func setup() {
        // navigation bar
        self.navigationItem.titleView = titleLabel
    }

}






































