//
//  HeroDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-03.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroDetailVC: UIViewController, HeroStretchHeaderViewDelegate {
    
    public var hero: Hero? {
        didSet {
            if view != nil {
                updateView()
            }
        }
    }
    
    private var heroStretchHeaderView = HeroStretchHeaderView()
    private var abilityTVC = AbilityTVC()
    private var basicTVC = HeroBasicTVC()
    private var miscTVC = HeroMiscTVC()
    private var talentTVC = HeroTalentTVC()
    
    private var contentView = UIView()
    private var currentChildViewController: UIViewController?
    
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
        abilityTVC.abilities = hero.abilities?.array as? [Ability]
        basicTVC.hero = hero
        miscTVC.hero = hero
        talentTVC.talents = hero.talents.allObjects as? [Talent]
        
        swapChildViewController(to: miscTVC)
        
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
    
    func heroStretchHeaderView(_ headerView: HeroStretchHeaderView, didTapTab tab: HeroDetailTab) {
        print(tab)
        switch tab {
        case .ability:
            break
        case .detail:
            break
        case .misc:
            break
        case .talent:
            break
        }
    }
}
































