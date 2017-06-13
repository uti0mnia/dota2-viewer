//
//  HeroBasicTVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-14.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import CoreData


/*
 * This view controller is meant to handle basic details of a hero like attributes 
 * and stats. Most of the stats and the attributes can be changed with the slider.
 */
class HeroBasicTVC: UIViewController, UITableViewDataSource, HeroAttributeViewDelegate, HeroDelegate {
    
    private static let attributeReuseIdentifier = "attributeCell"
    private static let basicReuseIndentifier = "basicCell"
    
    private var tableView: UITableView!
    
    private var hero: Hero!
    private var heroData: [String: [String: String]]!
    private var heroDataKeys: [String]! // holds the keys in HeroData
    
    private var agility: Attribute!
    private var intelligence: Attribute!
    private var strength: Attribute!
    private var primaryAttribute: HeroAttribute!
    
    init(hero: Hero) {
        super.init(nibName: nil, bundle: nil)
        
        self.hero = hero
        self.hero.delegate = self
        
        self.heroData = hero.dataDictionary
        self.heroDataKeys = Array(self.heroData.keys)
        self.primaryAttribute = hero.primaryAttribute.heroAttribute
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(hero != nil, "Hero must be set for AbilityTVC")
        
        // configure table view
        tableView = UITableView(frame: self.view.bounds)
        tableView.register(HeroAttributeCell.self, forCellReuseIdentifier: HeroBasicTVC.attributeReuseIdentifier)
        tableView.register(HeroBasicCell.self, forCellReuseIdentifier: HeroBasicTVC.basicReuseIndentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        
        updateData()
    }
    
    private func updateData() {
        self.heroData = hero.dataDictionary
        
        tableView.beginUpdates()
        if let indexPaths = tableView.indexPathsForVisibleRows {
            tableView.reloadRows(at: indexPaths, with: .none)
        } else {
            tableView.reloadData()
        }
        tableView.endUpdates()
    }
    
    private func configure(_ cell: UITableViewCell, at indexPath: IndexPath) {
        if let cell = cell as? HeroAttributeCell {
            cell.setPrimaryAttribute(primaryAttribute)
            cell.agilityLabel.text = hero.agility.string(1)
            cell.intelligenceLabel.text = hero.intelligence.string(1)
            cell.strengthLabel.text = hero.strength.string(1)
        }
        
        if let cell = cell as? HeroBasicCell {
            // get the dictionary for the section so we can get good key/value pair
            let dictSection = heroData[heroDataKeys[indexPath.section]]!
            let keyText = Array(dictSection.keys)[indexPath.row] // the stat to display
            let valueText = dictSection[keyText] // the value of the stat to display
            
            cell.kvView.keyLabel.text = keyText
            cell.kvView.valueLabel.text = valueText
        }
    }
    
    // MARK: - HeroAttributeViewDelegate
    
    public func sliderDidChangeValue(_ newValue: Int) {
        hero.level = newValue
    }
    
    // MARK: - UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + heroDataKeys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        assert(section < heroDataKeys.count + 1, "Section out of bounds")
        
        if section == 0 {
            return 1
        } else {
            let key = heroDataKeys[section - 1]
            return heroData[key]!.count
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["Attributes"] + heroDataKeys
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: HeroBasicTVC.attributeReuseIdentifier,
                                                 for: indexPath) as! HeroAttributeCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: HeroBasicTVC.basicReuseIndentifier,
                                                 for: indexPath) as! HeroBasicCell
        }
        configure(cell, at: indexPath)
        return cell
    }
    
    // MARK: - HeroDelegate
    
    func heroDidUpdateLevel() {
        updateData()
    }
    
    
}
