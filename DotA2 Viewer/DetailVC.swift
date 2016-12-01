//
//  HeroDetailVC.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import CoreData
import SafariServices

class DetailVC: DAUIViewController {
    // MARK - Outlets
    @IBOutlet weak var containerView: UIView!
    
    // MARK - Properties
    var object: ListObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the container view
        containerView.frame = self.view.bounds
        
        guard object != nil else { return }
        
        // configure resize button (for ipad and Plus-landscape)
        self.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
        self.navigationItem.leftItemsSupplementBackButton = true
    }
    
}
































