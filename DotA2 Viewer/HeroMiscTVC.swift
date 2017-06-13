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
    
    public var hero: Hero!
    private var tableView: UITableView!
    private var dict: [String: String]!
    private var keys: [String]!
    
    init(hero: Hero) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(hero != nil, "Hero can't be nil")
        
        dict = hero.miscDictionary
        keys = Array(dict.keys)
        
        tableView = UITableView(frame: self.view.bounds)
        tableView.register(HeroMiscCell.self, forCellReuseIdentifier: HeroMiscTVC.miscReuseIdentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroMiscTVC.miscReuseIdentifier, for: indexPath) as! HeroMiscCell
        
        let key = keys[indexPath.row]
        cell.mainLabel.text = key
        cell.subLabel.text = dict[key]
        
        return cell
    }
    
}
