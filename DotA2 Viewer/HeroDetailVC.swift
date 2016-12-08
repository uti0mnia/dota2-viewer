//
//  HeroDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-03.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroDetailVC: DAUIViewController {
    // MARK - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK - Properties
    var hero: Hero!
    fileprivate var model: HeroDetailModel!
    fileprivate var cellIdentifiers = ["mainCell", "statsCell", "bioCell", "abilitiesCell"]
    
    // MARK - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        guard hero != nil else { return }
        
        // init the model
        model = HeroDetailModel(hero: hero)
        model.delegate = self
        
        // set the view up
        setNavBar()
        setup()
    }
    
    
    // TODO: Fix this
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    /* configure the navigation bar */
    fileprivate func setNavBar() {// set title
        let title = DAMainLabel(style: .xlarge)
        title.text = hero.name!
        title.sizeToFit()
        self.navigationItem.titleView = title
    }
    
    /* This function sets up the data to be displayed */
    fileprivate func setup() {
        tableView.register(UINib(nibName: "HeroMainCell", bundle: nil), forCellReuseIdentifier: cellIdentifiers[0])
        tableView.register(UINib(nibName: "HeroStatsCell", bundle: nil), forCellReuseIdentifier: cellIdentifiers[1])
        tableView.register(UINib(nibName: "DACollapsibleLabelCell", bundle: nil), forCellReuseIdentifier: cellIdentifiers[2])
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    /* This fuctions reloads the labels in the cells that are level dependent */
    fileprivate func reloadLevel() {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? HeroMainCell {
            cell.levelLabel.text = "Level \(model.level)"
            cell.attribute1View.currentValue.text = String(format: "%.0f (+%.1f)", model.strength, model.strengthIncrement)
            cell.attribute2View.currentValue.text = String(format: "%.0f (+%.1f)", model.agility, model.agilityIncrement)
            cell.attribute3View.currentValue.text = String(format: "%.0f (+%.1f)", model.intelligence, model.intelligenceIncrement)
        }
        
        if let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? HeroStatsCell {
            cell.baseStatsView.armorLabel.text = String(format: "%.2f", model.armor)
            cell.baseStatsView.hpLabel.text = String(format: "%.0f + %.1f", model.hp, model.hpRegen)
            cell.baseStatsView.manaLabel.text = String(format: "%.0f + %.1f", model.mana, model.manaRegen)
            cell.baseStatsView.damageLabel.text = String(format: "%.0f-%.0f", model.damage.min, model.damage.max)
            cell.baseStatsView.attackPerSLabel.text = String(format: "%.2f", model.attackPerS)
            cell.baseStatsView.spellDmgLabel.text = String(format: "%.2f%@", model.spellDamage, "%")
        }
        
    }
    

}

extension HeroDetailVC: UITableViewDelegate, UITableViewDataSource {
    /* configures a given cell at a given index */
    fileprivate func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        if let cell = cell as? HeroMainCell {
            // ** Immediate info
            cell.heroImageView.image = hero.getImage()
            cell.levelLabel.text = "Level \(model.level)"
            cell.attackTypeLabel.text = (hero.miscStats?.projectileSpeed ?? "" == "Instant") ? "Melee" : "Ranged"
            cell.rolesLabel.text = (hero.roles!.allObjects as! [ArrayValue]).map({ $0.value ?? "" }).joined(separator: ", ")
            cell.slider.delegate = self
            
            // ** Attribute
            cell.attribute1View.imageView.image = #imageLiteral(resourceName: "strength_icon.png") // strength
            cell.attribute1View.currentValue.text = String(format: "%.0f (+%.1f)", model.strength, model.strengthIncrement)
            cell.attribute2View.imageView.image = #imageLiteral(resourceName: "agility_icon.png") // agility
            cell.attribute2View.currentValue.text = String(format: "%.0f (+%.1f)", model.agility, model.agilityIncrement)
            cell.attribute3View.imageView.image = #imageLiteral(resourceName: "intelligence_icon.png") // intelligence
            cell.attribute3View.currentValue.text = String(format: "%.0f (+%.1f)", model.intelligence, model.intelligenceIncrement)
            
            return
        }
        
        if let cell = cell as? HeroStatsCell {
            // ** Base Stats
            cell.baseStatsView.armorLabel.text = String(format: "%.2f", model.armor)
            cell.baseStatsView.hpLabel.text = String(format: "%.0f + %.1f", model.hp, model.hpRegen)
            cell.baseStatsView.manaLabel.text = String(format: "%.0f + %.1f", model.mana, model.manaRegen)
            cell.baseStatsView.damageLabel.text = String(format: "%.0f-%.0f", model.damage.min, model.damage.max)
            cell.baseStatsView.attackPerSLabel.text = String(format: "%.2f", model.attackPerS)
            cell.baseStatsView.spellDmgLabel.text = String(format: "%.2f%@", model.spellDamage, "%")
            
            // ** Misc Stats
            cell.miscStatsView.attackAnimationLabel.text = model.attackAnimation
            cell.miscStatsView.attackRangeLabel.text = model.attackRange
            cell.miscStatsView.collisionSizeLabel.text = model.collisionSize
            cell.miscStatsView.magicResistanceLabel.text = model.magicResistance
            cell.miscStatsView.moveSpeedLabel.text = model.movementSpeed
            cell.miscStatsView.projectileSpeedLabel.text = model.projectileSpeed
            cell.miscStatsView.turnRateLabel.text = model.turnRate
            cell.miscStatsView.visionLabel.text = model.visionRange
            
            return
        }
        
        if let cell = cell as? DACollapsibleLabelCell {
            if indexPath.row == 2 {
                cell.descriptionLabel.text = "Bio"
                cell.collapsibleTextLabel.text = model.bio
            }
        }
    }
    
    /* lets the tableview know how many cells to display */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    /* lets the tableview know what cell to display */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row], for: indexPath)
        configure(cell: cell, at: indexPath)
        return cell
    }
    
    /* function that handles the selection of a cell */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let expandableCell = cell as? ExpandableCellProtocol {
            if #available(iOS 10, *) {
                UIView.animate(withDuration: 0.2, animations: {
                    expandableCell.toggle()
                })
                cell?.contentView.layoutIfNeeded()
                tableView.beginUpdates()
                tableView.endUpdates()
            } else {
                UIView.animate(withDuration: 0.2) {
                    expandableCell.toggle()
                    cell?.contentView.layoutIfNeeded()
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
            }
        }
    }
    
}

extension HeroDetailVC: DASliderDelegate {
    func slider(_ slider: DASlider, didUpdateTo value: Int) {
        model.level = value
    }
}

extension HeroDetailVC: HeroDetailModelDelegate {
    func modelDidUpdate() {
        // reload data
        reloadLevel()
    }
}
































