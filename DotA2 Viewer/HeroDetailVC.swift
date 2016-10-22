//
//  HeroDetailVC.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-22.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroDetailVC: ObjectDetailVC {

    override var object: ListObject! {
        didSet {
            setView()
            refineView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setView() {
        
    }
    
    private func refineView() {
        
    }

}
