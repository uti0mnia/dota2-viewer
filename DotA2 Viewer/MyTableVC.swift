//
//  MyTableVC.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-11-02.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit


// this VC is meant to have a tableview that can be controlled by the CustomTabVC
class MyTableVC: DAUIViewController {

    lazy var tableView: DAMainTabelView = {
        let tv = DAMainTabelView()
        tv.sectionIndexColor = UIColor.red
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        // constraints
        let views: [String: Any] = ["tableView": tableView]
        var constrainsts = [NSLayoutConstraint]()
        let hlayout = NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|",
                                                     options: [],
                                                     metrics: nil,
                                                     views: views)
        let vlayout = NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|",
                                                     options: [],
                                                     metrics: nil,
                                                     views: views)
        constrainsts += hlayout
        constrainsts += vlayout
        NSLayoutConstraint.activate(constrainsts)
    }

}
