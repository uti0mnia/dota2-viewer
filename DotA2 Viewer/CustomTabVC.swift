//
//  CustomTabVC.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-19.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class CustomTabVC: UIViewController {
    
    // outlets
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var containerView: UIView!
    
    // variables for keeping track of stuff
    var objectForDetail: ListObject?
    var currentChild: ObjectListVC!
    
    // view controllers for content view
    lazy var heroListVC: HeroListVC = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HeroListVC") as! HeroListVC
        self.displayContentController(vc)
        return vc
        
    }()
    
    lazy var itemListVC: ItemListVC = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ItemListVC") as! ItemListVC
        self.displayContentController(vc)
        return vc
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the table view
        configureTabView()
        
        // configure the first container view
        let heroVC = HeroListVC()
        self.displayContentController(heroVC)
        
    }
    
    
    private func configureTabView() {
        tabBar.tintColor = UIColor.red
        tabBar.selectedItem = tabBar.items?.first
        tabBar.delegate = self
    }
    
    fileprivate func displayContentController(_ controller: ObjectListVC) {
        self.addChildViewController(controller) // add child VC
        self.currentChild = controller // set the reference
        self.containerView.addSubview(controller.view) // add child view
        controller.view.frame = self.containerView.bounds // configure frame
        controller.didMove(toParentViewController: self) // notify vc
        controller.tableView.delegate = self // set the delegate for didSelect
    }
    
    fileprivate func cycleFrom(viewController oldVC: UIViewController, toViewController newVC: ObjectListVC) {
        // remove the oldVC's view and itself
        oldVC.view.removeFromSuperview()
        oldVC.removeFromParentViewController()
        
        // display the newVC
        displayContentController(newVC)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard objectForDetail != nil else { return }
        if segue.identifier == "showDetail" {
            if let vc = (segue.destination as? UINavigationController)?.viewControllers.first as? DetailVC {
                vc.object = objectForDetail
            }
        }
    }
    
    
}

extension CustomTabVC: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title! {
        case "Hero":
            if let currentVC = self.childViewControllers.first {
                cycleFrom(viewController: currentVC, toViewController: heroListVC)
            }
            
        case "Item":
            if let currentVC = self.childViewControllers.first {
                cycleFrom(viewController: currentVC, toViewController: itemListVC)
            }
            
        default:
            break
        }
    }
}

extension CustomTabVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        objectForDetail = currentChild.fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


























