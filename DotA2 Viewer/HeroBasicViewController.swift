//
//  HeroBasicViewController.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-14.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import CoreData
import SnapKit


/*
 * This view controller is meant to handle basic details of a hero like attributes 
 * and stats. Most of the stats and the attributes can be changed with the slider.
 */
class HeroBasicViewController: UIViewController, UITableViewDataSource, HeroAttributeViewDelegate, HeroDelegate {
    
    private static let basicReuseIndentifier = "basicCell"
    
    private var tableView = UITableView()
    private var attributeView = HeroAttributeView()
    
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
    
    private var primaryAttribute: HeroAttribute?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func addContraints() {
        attributeView.translatesAutoresizingMaskIntoConstraints = false
        attributeView.snp.makeConstraints() { make in
            make.left.top.right.equalTo(view)
            make.bottom.equalTo(tableView.snp.top)
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints() { make in
            make.left.bottom.right.equalTo(view)
        }
    }
    
    private func commonInit() {
        tableView.register(HeroBasicCell.self, forCellReuseIdentifier: HeroBasicViewController.basicReuseIndentifier)
        tableView.dataSource = self
        
        attributeView.delegate = self
        
        view.addSubview(tableView)
        view.addSubview(attributeView)
        
        addContraints()
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
        
        attributeView.setPrimaryAttribute(primaryAttribute)
        attributeView.agilityLabel.text = hero?.agility.uti_string(1)
        attributeView.intelligenceLabel.text = hero?.intelligence.uti_string(1)
        attributeView.strengthLabel.text = hero?.strength.uti_string(1)
    }
    
    private func configure(_ cell: HeroBasicCell, at indexPath: IndexPath) {
        // TODO: Make this actually readable.
        // get the dictionary for the section so we can get good key/value pair
        let dictSection = heroData[heroDataKeys[indexPath.section]]!
        let keyText = Array(dictSection.keys)[indexPath.row] // the stat to display
        let valueText = dictSection[keyText] // the value of the stat to display
        
        cell.kvView.keyLabel.text = keyText
        cell.kvView.valueLabel.text = valueText
    }
    
    // MARK: - HeroAttributeViewDelegate
    
    public func sliderDidChangeValue(_ newValue: Int) {
        hero?.level = newValue
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return heroDataKeys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        assert(section < heroDataKeys.count, "Section out of bounds")
        
        let key = heroDataKeys[section]
        return heroData[key]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroBasicViewController.basicReuseIndentifier,
                                                 for: indexPath) as! HeroBasicCell
        configure(cell, at: indexPath)
        return cell
    }
    
    // MARK: - HeroDelegate
    
    func heroDidUpdateLevel() {
        updateData()
    }
    
}
