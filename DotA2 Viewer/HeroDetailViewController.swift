//
//  HeroDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-03.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import SnapKit
import BetterSegmentedControl

class HeroDetailViewController: ObjectDetailViewController {
    
    public var hero: Hero? {
        didSet {
            if view != nil {
                updateView()
            }
        }
    }
    
    private var heroSegmentControl = BetterSegmentedControl(frame: CGRect.zero,
                                                            titles: ["Details", "Abilities", "Talents", "Misc"],
                                                            index: 0,
                                                            backgroundColor: Colours.primaryColour,
                                                            titleColor: Colours.defaultTextColour,
                                                            indicatorViewBackgroundColor: Colours.secondaryColour,
                                                            selectedTitleColor: Colours.defaultTextColour)
    override var segmentControl: BetterSegmentedControl {
        return heroSegmentControl
    }
    
    private var abilityCollectionViewController = AbilityCollectionViewController()
    private var basicViewController = HeroBasicViewController()
    private var miscViewController = HeroMiscViewController()
    private var talentViewController = HeroTalentViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.abilityCollectionViewController.loadViewIfNeeded()
            self.basicViewController.loadViewIfNeeded()
            self.miscViewController.loadViewIfNeeded()
            self.talentViewController.loadViewIfNeeded()
        }
    }
    
    private func updateView() {
        guard let hero = hero else {
            return
        }
        
        titleLabel.text = hero.name
        titleLabel.sizeToFit()
        
        abilityCollectionViewController.abilities = hero.abilities?.array as? [Ability]
        basicViewController.hero = hero
        miscViewController.hero = hero
        talentViewController.hero = hero
        
        swapChildViewController(to: basicViewController)
    }
    
    override public func viewControllerForControlIndex(_ index: UInt) -> UIViewController? {
        switch index {
        case 0:
            return basicViewController
        case 1:
            return abilityCollectionViewController
        case 2:
            return talentViewController
        case 3:
            return miscViewController
        default:
            return nil
        }
    }
}
