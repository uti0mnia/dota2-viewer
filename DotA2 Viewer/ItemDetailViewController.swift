//
//  ItemDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import SnapKit
import BetterSegmentedControl

class ItemDetailViewController: ObjectDetailViewController, ItemHeaderViewDelegate, ItemBasicViewControllerDelegate {
   
    public var item: Item? {
        didSet {
            if view != nil {
                updateView()
            }
        }
    }
    
    override public var objectHeaderView: ObjectHeaderView? {
        return itemHeaderView
    }
    
    private var itemSegmentControl = BetterSegmentedControl(frame: CGRect.zero,
                                                            titles: ["Details", "Abilities"],
                                                            index: 0,
                                                            backgroundColor: Colours.primaryColour,
                                                            titleColor: Colours.defaultTextColour,
                                                            indicatorViewBackgroundColor: Colours.secondaryColour,
                                                            selectedTitleColor: Colours.defaultTextColour)
    override var segmentControl: BetterSegmentedControl {
        return itemSegmentControl
    }
    
    private var itemHeaderView = ItemHeaderView()
    private var abilityCollectionViewController = AbilityCollectionViewController()
    private var basicViewController = ItemBasicViewController()
    
    private var currentTab: ItemDetailTab = .basic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemHeaderView.delegate = self
        
        DispatchQueue.main.async {
            self.abilityCollectionViewController.loadViewIfNeeded()
            self.basicViewController.loadViewIfNeeded()
        }
    }
    
    private func updateView() {
        guard let item = item else {
            return
        }
        
        titleLabel.text = item.name
        titleLabel.sizeToFit()
        
        // We dont want to show the buttons
        itemHeaderView.imageView.image = UIImage(named: item.imageName)
        itemHeaderView.shouldShowButtons = !(item.abilities?.array as? [Ability] == nil || item.abilities!.array.count == 0)
        abilityCollectionViewController.abilities = item.abilities?.array as? [Ability]
        basicViewController.item = item
        
        swapChildViewController(to: basicViewController)
        currentTab = .basic
    }
    
    override func viewControllerForControlIndex(_ index: UInt) -> UIViewController? {
        switch index {
        case 0:
            return basicViewController
        case 1:
            return abilityCollectionViewController
        default:
            return nil
        }
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
}
