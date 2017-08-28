//
//  CustomTabVC.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-19.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, HeroListViewControllerDelegate, ItemListViewControllerDelegate, UITabBarDelegate {
    
    @IBOutlet weak var tabBar: DATabBar!
    
    private var contentView = UIView()
    
    private var heroDetailViewController = HeroDetailViewController()
    private var heroListViewController = HeroListViewController()
    private var itemDetailViewController = ItemDetailViewController()
    private var itemListViewController = ItemListViewController()
    
    private var currentChildViewController: ObjectListViewController?
    
    private var contentViewBottomConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colours.primaryColour
        view.addSubview(contentView)
        
        // Find a better way to load this.
        swapChildViewController(to: itemListViewController)
        swapChildViewController(to: heroListViewController)
        
        tabBar.selectedItem = tabBar.items?.first!
        
        let barButton = UIBarButtonItem()
        barButton.title = ""
        navigationItem.backBarButtonItem = barButton
        
        contentView.snp.makeConstraints() { make in
            make.left.right.equalTo(view)
            make.top.equalTo(topLayoutGuide.snp.bottom)
            contentViewBottomConstraint = make.bottom.equalTo(tabBar.snp.top).constraint
        }
        contentView.backgroundColor = Colours.primaryColour
        
        heroListViewController.delegate = self
        itemListViewController.delegate = self
        
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.contentMode = .scaleAspectFill
        
        // Need to figure our why I need this.
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        currentChildViewController?.tableView.searchBar.becomeFirstResponder()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let offset = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            contentViewBottomConstraint?.update(offset: -(offset - tabBar.bounds.height))
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        contentViewBottomConstraint?.update(offset: 0)
    }
    
    private func swapChildViewController(to viewController: ObjectListViewController) {
        if viewController == currentChildViewController {
            return
        }
        
        currentChildViewController?.willMove(toParentViewController: nil)
        
        addChildViewController(viewController)
        contentView.addSubview(viewController.view)
        
        let width = contentView.bounds.width
        let x: CGFloat = viewController is HeroListViewController ? -width : width
        viewController.view.frame = contentView.bounds
        viewController.view.frame.origin.x = x
        
        UIView.animate(withDuration: 0.2, animations: {
            viewController.view.frame.origin.x = 0
            self.currentChildViewController?.view.frame.origin.x = -x
        }) { success in
            self.currentChildViewController?.view.removeFromSuperview()
            self.currentChildViewController?.removeFromParentViewController()
            
            viewController.didMove(toParentViewController: self)
            self.currentChildViewController = viewController
        }
        
    }
    
    // MARK: - UITabBarDelegate
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            swapChildViewController(to: heroListViewController)
        } else {
            swapChildViewController(to: itemListViewController)
        }
    }
    
    // MARK:  - HeroListViewControllerDelegate
    
    func heroListViewController(_ heroListViewController: HeroListViewController, didSelectHero hero: Hero) {
        heroDetailViewController.hero = hero
        heroDetailViewController.object = hero
        showDetailViewController(heroDetailViewController, sender: nil)
    }
    
    // MARK : - ItemListViewControllerDelegate
    
    func itemListViewController(_ itemListViewController: ItemListViewController, didSelectItem item: Item) {
        itemDetailViewController.item = item
        showDetailViewController(itemDetailViewController, sender: nil)
    }
}
