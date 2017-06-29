//
//  HeroDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-03.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroDetailVC: UIViewController, HeroHeaderViewDelegate {
    
    public var hero: Hero? {
        didSet {
            if view != nil {
                updateView()
            }
        }
    }
    
    private var heroHeaderView = HeroHeaderView()
    private var abilityCollectionViewController = AbilityCollectionViewController()
    private var basicViewController = HeroBasicTVC()
    private var miscViewController = HeroMiscTVC()
    private var talentViewController = HeroTalentTVC()
    
    private var contentView = UIView()
    private var currentChildViewController: UIViewController?
    private var currentTab: HeroDetailTab = .basic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = UIRectEdge()
        
        heroHeaderView.backgroundColor = UIColor.flatBlack()
        contentView.backgroundColor = UIColor.flatBlack()
        
        view.addSubview(heroHeaderView)
        view.addSubview(contentView)
        
        heroHeaderView.delegate = self
        
        addConstraints()
    }
    
    private func updateView() {
        guard let hero = hero else {
            return
        }
        self.title = hero.name
        
        heroHeaderView.imageView.image = UIImage(named: hero.imageName)
        abilityCollectionViewController.abilities = hero.abilities?.array as? [Ability]
        basicViewController.hero = hero
        miscViewController.hero = hero
        talentViewController.talents = hero.talents.allObjects as? [Talent]
        
        swapChildViewController(to: basicViewController)
        
    }
    
    private func addConstraints() {
        heroHeaderView.snp.makeConstraints() { make in
            make.left.top.right.equalTo(view)
            make.bottom.equalTo(contentView.snp.top)
        }
        
        contentView.snp.makeConstraints() { make in
            make.left.bottom.right.equalTo(view)
        }
    }
    
    // TODO: Animate this stuff.
    private func swapChildViewController(to viewController: UIViewController) {
        
        currentChildViewController?.willMove(toParentViewController: nil)
        currentChildViewController?.view.removeFromSuperview()
        currentChildViewController?.removeFromParentViewController()
        
        currentChildViewController = viewController
        
        addChildViewController(viewController)
        contentView.addSubview(viewController.view)
        viewController.view.frame = contentView.bounds // TODO: Fix this shit. ?? 
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParentViewController: self)
        currentTab = .basic
    }
    
    // MARK: - HeroStretchHeaderViewDelegate
    
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
