//
//  ObjectDetailVC.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-22.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

protocol DetailVCDelegate {
    func didSelectObject(object: ListObject)
}


class ObjectDetailVC: UIViewController {

    var object: ListObject!
    var del: DetailVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
