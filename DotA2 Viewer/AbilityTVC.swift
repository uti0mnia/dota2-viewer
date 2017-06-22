//
//  AbilityTVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-10.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class AbilityTVC: UIViewController, UITableViewDataSource {
    
    private static let abilityCellIndetifier = "abilityCell"
    private static let estimatedRowHeight: CGFloat = 500
    
    private var tableView: UITableView!
    
    public var abilities: [Ability]? {
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
        tableView.register(AbilityCell.self, forCellReuseIdentifier: AbilityTVC.abilityCellIndetifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = AbilityTVC.estimatedRowHeight
        
        view.addSubview(tableView)
    }
    
    private func configure(_ cell: AbilityCell, at indexPath: IndexPath) {
        if let ability = abilities?[indexPath.row] {
            cell.name = ability.name
            cell.specials = ability.specialIcons
            cell.abilityImage = UIImage(named: ability.imageName)
            cell.abilityDescription = ability.descrip
            cell.types = ability.types?.array as? [ModifiableValue]
            cell.data = ability.data?.array as? [ModifiableValue]
            cell.modifiers = ability.modifiers?.allObjects as? [Modifier]
            cell.cooldown = ability.cooldown
            cell.mana = ability.mana
            cell.notes = ability.notes?.array as? [Note]
            
            cell.setNeedsLayout()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return abilities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AbilityTVC.abilityCellIndetifier) as! AbilityCell
        configure(cell, at: indexPath)
        
        return cell
    }

}
