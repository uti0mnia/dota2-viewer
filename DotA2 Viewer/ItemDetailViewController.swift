//
//  ItemDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, ItemHeaderViewDelegate {
   
    public var item: Item? {
        didSet {
            if view != nil {
                updateView()
            }
        }
    }
    
    private var itemHeaderView = ItemHeaderView()
    private var abilityCollectionViewController = AbilityCollectionViewController()
    private var basicViewController = ItemBasicViewController()
    
    private var contentView = UIView()
    private var currentChildViewController: UIViewController?
    private var currentTab: ItemDetailTab = .basic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemHeaderView.backgroundColor = UIColor.flatBlack()
        contentView.backgroundColor = UIColor.flatBlack()
        
        view.addSubview(itemHeaderView)
        view.addSubview(contentView)
        
        itemHeaderView.delegate = self
        
        addConstraints()
    }
    
    private func updateView() {
        guard let item = item else {
            return
        }
        self.title = item.name
        
        itemHeaderView.item = item
        abilityCollectionViewController.abilities = item.abilities?.array as? [Ability]
        basicViewController.item = item
        
        swapChildViewController(to: basicViewController)
        currentTab = .basic
    }
    
    private func addConstraints() {
        itemHeaderView.snp.makeConstraints() { make in
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
        
    }
    
    // MARK: - ItemHeaderViewDelegate
    func itemHeaderView(_ itemHeaderView: ItemHeaderView, didTapTab tab: ItemDetailTab) {
        guard tab != currentTab else {
            return
        }
        currentTab = tab
        
        switch tab {
        case .basic:
            swapChildViewController(to: basicViewController)
        case .ability:
            swapChildViewController(to: abilityCollectionViewController)
            
        }
    }
    
    func itemHeaderViewDidTapOnImageView() {
        
    }
}











































