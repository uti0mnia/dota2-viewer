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
    
    private var heroStretchHeaderView = HeroHeaderView()
    private var ablilityVCV = AbilityCollectionViewController()
    private var basicTVC = HeroBasicTVC()
    private var miscTVC = HeroMiscTVC()
    private var talentTVC = HeroTalentTVC()
    
    private var contentView = UIView()
    private var currentChildViewController: UIViewController?
    private var currentTab: HeroDetailTab = .basic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(heroStretchHeaderView)
        view.addSubview(contentView)
        
        heroStretchHeaderView.delegate = self
        
        // TODO: Remove
        view.backgroundColor = UIColor.black
        contentView.backgroundColor = UIColor.flatRed()
        
        addConstraints()
    }
    
    private func updateView() {
        guard let hero = hero else {
            return
        }
        self.title = hero.name
        
        heroStretchHeaderView.imageView.image = UIImage(named: hero.imageName)
        ablilityVCV.abilities = hero.abilities?.array as? [Ability]
        basicTVC.hero = hero
        miscTVC.hero = hero
        talentTVC.talents = hero.talents.allObjects as? [Talent]
        
        swapChildViewController(to: basicTVC)
        
    }
    
    private func addConstraints() {
        heroStretchHeaderView.snp.makeConstraints() { make in
            make.left.equalTo(view)
            make.top.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(contentView.snp.top)
        }
        
        contentView.snp.makeConstraints() { make in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
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
        
    }
    
    // MARK: - HeroStretchHeaderViewDelegate
    
    func heroHeaderView(_ headerView: HeroHeaderView, didTapTab tab: HeroDetailTab) {
        guard tab != currentTab else {
            return
        }
        currentTab = tab
        
        switch tab {
        case .ability:
            swapChildViewController(to: ablilityVCV)
        case .basic:
            swapChildViewController(to: basicTVC)
        case .misc:
            swapChildViewController(to: miscTVC)
        case .talent:
            swapChildViewController(to: talentTVC)
        }
    }
}
