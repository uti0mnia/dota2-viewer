//
//  HeroMiscTVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-12.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class HeroMiscTVC: UIViewController, UITableViewDataSource {
    
    private static let miscReuseIdentifier = "miscCell"
    
    public var hero: Hero? {
        didSet {
            guard let hero = hero else {
                tableView.reloadData()
                return
            }
            
            dict = hero.miscDictionary
            keys = Array(dict!.keys)
            
            tableView.reloadData()
        }
    }
    private var tableView: UITableView!
    private var dict: [String: String]?
    private var keys: [String]?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        tableView = UITableView(frame: self.view.bounds)
        tableView.register(HeroMiscCell.self, forCellReuseIdentifier: HeroMiscTVC.miscReuseIdentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroMiscTVC.miscReuseIdentifier, for: indexPath) as! HeroMiscCell
        
        if let key = keys?[indexPath.row] {
            cell.mainLabel.text = key
            cell.subLabel.text = dict?[key]
        }
        
        return cell
    }
    
}
