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

class ItemDetailViewController: ObjectDetailViewController, ItemBasicViewControllerDelegate {
   
    public var item: Item? {
        didSet {
            if view != nil {
                updateView()
            }
        }
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
    
    private var abilityCollectionViewController = AbilityCollectionViewController()
    private var basicViewController = ItemBasicViewController()
    
    private var titles: [String] {
        if item?.abilities == nil || item?.abilities?.count == 0 {
            return ["Details"]
        }
        
        return ["Details", "Abilities"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basicViewController.delegate = self
        
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
        
        segmentControl.titles = self.titles
        
        abilityCollectionViewController.abilities = item.abilities?.array as? [Ability]
        basicViewController.item = item
        
        swapChildViewController(to: basicViewController)
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
}
