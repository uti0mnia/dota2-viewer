//
//  HeroTalentTVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-12.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class HeroTalentTVC: UIViewController, UITableViewDataSource {
    
    private static let talentReuseIdentifier = "talentCell"
    
    private var tableView: UITableView!
    public var talents: [Talent]? {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        tableView.register(HeroTalentCell.self, forCellReuseIdentifier: HeroTalentTVC.talentReuseIdentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroTalentTVC.talentReuseIdentifier, for: indexPath) as! HeroTalentCell
        
        if let talent = talents?[indexPath.row] {
            cell.leftLabel.text = talent.left
            cell.rightLabel.text = talent.right
            cell.levelView.level = Int(talent.level)
        }
        
        return cell
    }
}
