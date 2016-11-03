//
//  CustomTabVC.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-19.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class CustomTabVC: UIViewController {
    // constants
    let kAnimateTime: TimeInterval = 0.3
    
    // outlets
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var containerView: UIView!
    
    // variables for keeping track of stuff
    var objectForDetail: ListObject?
    var currentChild: MyTableVC!
    
    // view controllers for content view
    lazy var heroListVC: HeroListVC = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HeroListVC") as! HeroListVC
        return vc
        
    }()
    
    lazy var itemListVC: ItemListVC = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ItemListVC") as! ItemListVC
        return vc
        
    }()
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.tintColor = UIColor.red
        sb.searchBarStyle = .minimal
        sb.showsCancelButton = true
        return sb
    }()
    
    var searchBarButton: UIBarButtonItem!
    
    /* Methods */
    // superclass methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the UI Elements
        navigationItem.title = "Heroes"
        searchBarButton = navigationItem.rightBarButtonItem // the search button
        configureTabView()
        
        // configure the first container view
        displayContentController(heroListVC)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // nsnotification
        NotificationCenter.default.addObserver(self, selector: #selector(CustomTabVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CustomTabVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard objectForDetail != nil else { return }
        if segue.identifier == "showDetail" {
            if let vc = (segue.destination as? UINavigationController)?.viewControllers.first as? DetailVC {
                vc.object = objectForDetail
                //vc.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            }
        }
    }
    
    // view settings
    private func configureTabView() {
        tabBar.tintColor = UIColor.red // set tint
        tabBar.selectedItem = tabBar.items?.first // set hero as selected
        tabBar.delegate = self // set delegate
    }
    
    
    // view control flow
    fileprivate func displayContentController(_ controller: MyTableVC) {
        self.addChildViewController(controller) // add child VC
        self.currentChild = controller // set the reference
        self.containerView.addSubview(controller.view) // add child view
        controller.view.frame = self.containerView.bounds // configure frame
        controller.didMove(toParentViewController: self) // notify vc
        if controller is ObjectListVC {
            (controller as! ObjectListVC).tableView.delegate = self // set the delegate for didSelect
            searchBar.delegate = (controller as! ObjectListVC)
        }
    }
    
    fileprivate func cycleFrom(viewController oldVC: UIViewController, toViewController newVC: MyTableVC) {
        // display the newVC
        displayContentController(newVC)
        newVC.view.alpha = 0
        UIView.animate(withDuration: kAnimateTime, animations: {
            newVC.view.alpha = 1
            oldVC.view.alpha = 0
        }, completion: { _ in
            // remove the oldVC's view and itself
            oldVC.view.removeFromSuperview()
            oldVC.removeFromParentViewController()
        })
        
    }
    
    
    // search functionality
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        showSearchBar()
    }
    
    func showSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.alpha = 0
        navigationItem.setRightBarButton(nil, animated: true)
        UIView.animate(withDuration: kAnimateTime, animations: {
            self.searchBar.alpha = 1
        }, completion: {_ in
            self.searchBar.becomeFirstResponder()
        })
    }
    
    func hideSearchBar() {
        UIView.animate(withDuration: kAnimateTime, animations: {
            self.navigationItem.titleView?.alpha = 0
            self.searchBar.resignFirstResponder()
            }, completion: { _ in
            self.navigationItem.titleView = nil
            self.navigationItem.setRightBarButton(self.searchBarButton, animated: true)
        })
    }
}

/* Tab bar delegate */
extension CustomTabVC: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title! {
        case "Hero":
            if let currentVC = self.childViewControllers.first {
                navigationItem.title = "Heroes"
                cycleFrom(viewController: currentVC, toViewController: heroListVC)
            }
            
        case "Item":
            if let currentVC = self.childViewControllers.first {
                navigationItem.title = "Items"
                cycleFrom(viewController: currentVC, toViewController: itemListVC)
            }
        
        default:
            break
        }
    }
}

/* Tableview delegate */
extension CustomTabVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch currentChild {
        case is ObjectListVC:
            // get the item/hero select
            objectForDetail = (currentChild as! ObjectListVC).fetchedResultsController.object(at: indexPath)
            
            // perform the segue
            self.performSegue(withIdentifier: "showDetail", sender: nil)
            
            // clear the selection
            tableView.deselectRow(at: indexPath, animated: false)
            
            // clear the search
            searchBar.text = ""
            (currentChild as! ObjectListVC).clearFilter()
            
            // hide the search bar
            hideSearchBar()
        default:
            break
        }
    }
}

/* Keyboard Handling */
extension CustomTabVC {
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // shrink the size of the screen so the keyboard doesn't block anything (except the tab view)
            let offset = keyboardSize.height - tabBar.frame.height
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: UIScreen.main.bounds.height - offset)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.height != UIScreen.main.bounds.height {
            // change the height of the view to the size of the available space
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: UIScreen.main.bounds.height)
        }
    }
}

























