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
    private static let estimatedRowHeight: CGFloat = 600
    
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
            cell.nameLabel.text = ability.name
            cell.specialsLabel.attributedText = ability.specialIcons
            cell.abilityImageView.image = UIImage(named: ability.imageName)
            
            cell.abilityStackView.types = ability.types?.array as? [ModifiableValue]
            cell.abilityStackView.abilityDescription = ability.descrip
            cell.abilityStackView.data = ability.data?.array as? [ModifiableValue]
            cell.abilityStackView.modifiers = ability.modifiers?.allObjects as? [Modifier]
            cell.abilityStackView.cooldown = ability.cooldown
            cell.abilityStackView.mana = ability.mana
            cell.abilityStackView.notes = ability.notes?.array as? [Note]
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
