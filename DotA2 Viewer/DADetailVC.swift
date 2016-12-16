//
//  DetailVC.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DADetailVC: UIViewController {
    // MARK - Properties
    var object: ListObject!
    internal var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
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
        
        // scrollview
        self.view.addSubview(scrollView)
        var constraints = [NSLayoutConstraint]()
        constraints += createConstraints(withVisual: "H:|[scrollView]|", withViews: ["scrollView": scrollView], options: .alignAllCenterX)
        constraints += createConstraints(withVisual: "V:|[scrollView]|", withViews: ["scrollView": scrollView], options: .alignAllCenterX)
        self.view.addConstraints(constraints)
    }
    
    internal func setup() {
        // navigation bar
        self.navigationItem.titleView = titleLabel
    }
    
    internal func createConstraints(withVisual str: String, withViews views: [String: Any], options: NSLayoutFormatOptions = []) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: str, options: options, metrics: nil, views: views)
    }
    
    

}







































