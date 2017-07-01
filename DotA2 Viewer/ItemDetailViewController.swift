//
//  ItemDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, ItemHeaderViewDelegate, ItemBasicViewControllerDelegate {
   
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
        
        edgesForExtendedLayout = UIRectEdge()
        
        itemHeaderView.backgroundColor = UIColor.flatForestGreen()
        contentView.backgroundColor = UIColor.flatForestGreen()
        
        view.addSubview(itemHeaderView)
        view.addSubview(contentView)
        
        itemHeaderView.delegate = self
        basicViewController.delegate = self
        
        addConstraints()
    }
    
    private func updateView() {
        guard let item = item else {
            return
        }
        self.title = item.name
        
        // We dont want to show the buttons
        itemHeaderView.imageView.image = UIImage(named: item.imageName)
        itemHeaderView.shouldShowButtons = !(item.abilities?.array as? [Ability] == nil || item.abilities!.array.count == 0)
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
    
    // MARK: - ItemBasicViewControllerDelegate
    
    func itemBasicViewController(_ itemBasicViewController: ItemBasicViewController, didSelectItem item: Item) {
        let nextViewController = ItemDetailViewController()
        nextViewController.item = item
        self.navigationController?.pushViewController(nextViewController, animated: true)
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
