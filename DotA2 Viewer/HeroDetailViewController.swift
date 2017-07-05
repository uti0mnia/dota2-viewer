//
//  HeroDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-03.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import SnapKit

class HeroDetailViewController: ObjectDetailViewController, HeroHeaderViewDelegate {
    
    public var hero: Hero? {
        didSet {
            if view != nil {
                updateView()
            }
        }
    }
    
    override public var objectHeaderView: ObjectHeaderView {
        return heroHeaderView
    }
    
    private var heroHeaderView = HeroHeaderView()
    private var abilityCollectionViewController = AbilityCollectionViewController()
    private var basicViewController = HeroBasicViewController()
    private var miscViewController = HeroMiscViewController()
    private var talentViewController = HeroTalentViewController()
    
    private var currentTab: HeroDetailTab = .basic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroHeaderView.delegate = self
    }
    
    private func updateView() {
        guard let hero = hero else {
            return
        }
        
        titleLabel.text = hero.name
        titleLabel.sizeToFit()
        
        heroHeaderView.imageView.image = UIImage(named: hero.imageName)
        abilityCollectionViewController.abilities = hero.abilities?.array as? [Ability]
        basicViewController.hero = hero
        miscViewController.hero = hero
        talentViewController.hero = hero
        
        swapChildViewController(to: basicViewController)
        currentTab = .basic
        
    }
    
    // MARK: - HeroHeaderViewDelegate
    
    func heroHeaderView(_ headerView: HeroHeaderView, didTapTab tab: HeroDetailTab) {
        guard tab != currentTab else {
            return
        }
        currentTab = tab
        
        switch tab {
        case .ability:
            swapChildViewController(to: abilityCollectionViewController)
        case .basic:
            swapChildViewController(to: basicViewController)
        case .misc:
            swapChildViewController(to: miscViewController)
        case .talent:
            swapChildViewController(to: talentViewController)
        }
    }
}