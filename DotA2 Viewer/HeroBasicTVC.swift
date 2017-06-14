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
class HeroBasicTVC: UIViewController, UITableViewDataSource, HeroDelegate {
    
    private static let attributeReuseIdentifier = "attributeCell"
    private static let basicReuseIndentifier = "basicCell"
    
    private var tableView: UITableView!
    
    public var hero: Hero? {
        didSet {
            guard let hero = hero else {
                return
            }
            
            hero.delegate = self
            
            heroData = hero.dataDictionary
            heroDataKeys = Array(heroData.keys)
            primaryAttribute = hero.primaryAttribute.heroAttribute
            
            updateData()
        }
    }
    private var heroData = [String: [String: String]]()
    private var heroDataKeys = [String]() // holds the keys in HeroData
    
    private var agility: Attribute!
    private var intelligence: Attribute!
    private var strength: Attribute!
    private var primaryAttribute: HeroAttribute!

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
        let nib = UINib(nibName: HeroAttributeCell.nibName, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: HeroBasicTVC.attributeReuseIdentifier)
        tableView.register(HeroBasicCell.self, forCellReuseIdentifier: HeroBasicTVC.basicReuseIndentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
    }

    private func updateData() {
        if let hero = hero {
            heroData = hero.dataDictionary
        } else {
            heroData.removeAll(keepingCapacity: true)
        }
        
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
            cell.agilityLabel.text = hero?.agility.string(1)
            cell.intelligenceLabel.text = hero?.intelligence.string(1)
            cell.strengthLabel.text = hero?.strength.string(1)
        }
        
        if let cell = cell as? HeroBasicCell {
            // TODO: Make this actually readable.
            // get the dictionary for the section so we can get good key/value pair
            let dictSection = heroData[heroDataKeys[indexPath.section - 1]]!
            let keyText = Array(dictSection.keys)[indexPath.row] // the stat to display
            let valueText = dictSection[keyText] // the value of the stat to display
            
            cell.kvView.keyLabel.text = keyText
            cell.kvView.valueLabel.text = valueText
        }
    }
    
    // MARK: - HeroAttributeViewDelegate
    
    public func sliderDidChangeValue(_ newValue: Int) {
        hero?.level = newValue
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + heroDataKeys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        assert(section < 1 + heroDataKeys.count, "Section out of bounds")
        
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
