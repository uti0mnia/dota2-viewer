//
//  ItemDetailVC.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailVC: UIViewController {
    
    var item: Item!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure table view
        let rect = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
        tableView = UITableView(frame: rect, style: .plain)
//        tableView.delegate = self
//        tableView.dataSource = self
    }
    
    
    
}

//extension ItemDetailVC: UITableViewDelegate, UITableViewDataSource {
//    
//}
