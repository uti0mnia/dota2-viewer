//
//  CustomTabVC.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-19.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class CustomTabVC: DAUIViewController {
    // constants
    let kAnimateTime: TimeInterval = 0.3
    
    // outlets
    lazy var tabBar: DATabBar = {
        let tb = DATabBar()
        tb.translatesAutoresizingMaskIntoConstraints = false
        let hero = UITabBarItem(title: "Heroes", image: #imageLiteral(resourceName: "Heroes"), selectedImage: #imageLiteral(resourceName: "Heroes"))
        let item = UITabBarItem(title: "Items", image: #imageLiteral(resourceName: "Shop"), selectedImage: #imageLiteral(resourceName: "Shop"))
        tb.setItems([hero, item], animated: true)
        tb.selectedItem = hero
        tb.delegate = self
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: kDotaFontSmall], for: .normal)
        return tb
    }()
    
    lazy var heroTitle: DAMainLabel = {
        let label = DAMainLabel(style: .title)
        label.text = "Heroes"
        label.sizeToFit()
        return label
    }()
    
    lazy var itemTitle: DAMainLabel = {
        let label = DAMainLabel(style: .title)
        label.text = "Items"
        label.sizeToFit()
        return label
    }()
    
    var titleView: DAMainLabel! {
        didSet {
            self.navigationItem.titleView = titleView
        }
    }
    
    
    var containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
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
    
    lazy var searchBar: DASearchBar = {
        let sb = DASearchBar()
        return sb
    }()
    
    // on iPad the cancel button doesn't show so this is a work around
    lazy var cancelButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CustomTabVC.searchBarCancel))
        return btn
    }()
    
    // TODO: Make this button programmatically
    var searchBarButton: UIBarButtonItem!
    
    // MARK - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure container view
        self.view.addSubview(containerView)
        self.view.addSubview(tabBar)
        // set the constraints
        let horz = NSLayoutConstraint.constraints(withVisualFormat: "V:[top][view][tab]|",
                                               options: [],
                                               metrics: nil,
                                               views: ["top": topLayoutGuide,
                                                       "view": containerView,
                                                       "tab": tabBar])
        let vert = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                               options: [],
                                               metrics: nil,
                                               views: ["view": containerView])
        let vert2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|[tab]|",
                                                   options: [],
                                                   metrics: nil,
                                                   views: ["tab": tabBar])
        
        self.view.addConstraints(horz + vert + vert2)
        
        // configure the UI Elements
        titleView = heroTitle
        searchBarButton = navigationItem.rightBarButtonItem! // the search button
        
        // configure the first container view
        displayContentController(heroListVC)
        
        // hide the back button when pushing
        let btn = UIBarButtonItem()
        btn.title = ""
        navigationItem.backBarButtonItem = btn
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // nsnotification
        NotificationCenter.default.addObserver(self, selector: #selector(CustomTabVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CustomTabVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // set the title view
        switch tabBar.selectedItem!.title! {
        case "Heroes":
            titleView = heroTitle
        default:
            titleView = itemTitle
        }
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
            }
            // hide search bar if present
            if self.navigationItem.titleView != titleView {
                // clear the search
                searchBar.text = ""
                (currentChild as! ObjectListVC).clearFilter()
                
                // hide the search bar
                hideSearchBar()
                
            }
        }
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
        // set the navigation title view to be the search bar and hide the search bar
        self.navigationItem.titleView = searchBar
        searchBar.alpha = 0
        UIView.animate(withDuration: kAnimateTime, animations: {
            // slowly display the search bar
            self.searchBar.alpha = 1
        }, completion: {_ in
            // show the cancel button and make the search bar the first responder
            self.navigationItem.setRightBarButton(self.cancelButton, animated: true)
            self.searchBar.becomeFirstResponder()
        })
    }
    
    func hideSearchBar() {
        UIView.animate(withDuration: kAnimateTime,
                       animations: {
            // hide the search bar and resign its first responder status
            self.navigationItem.titleView?.alpha = 0
            self.searchBar.resignFirstResponder()
        },
                       completion: { _ in
                // set the title view to nil and reset the search button
                self.navigationItem.titleView = self.titleView
                self.navigationItem.setRightBarButton(self.searchBarButton, animated: true)
        })
    }
    
    func searchBarCancel() {
        if let child = currentChild as? ObjectListVC {
            child.cancelButtonPressed()
        }
    }
}

/* Tab bar delegate */
extension CustomTabVC: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title! {
        case "Heroes":
            guard currentChild is ItemListVC else { return }
            if let currentVC = self.childViewControllers.first {
                titleView = heroTitle
                cycleFrom(viewController: currentVC, toViewController: heroListVC)
            }
            
        case "Items":
            guard currentChild is HeroListVC else { return }
            if let currentVC = self.childViewControllers.first {
                titleView = itemTitle
                cycleFrom(viewController: currentVC, toViewController: itemListVC)
            }
        
        default:
            break
        }
    }
}

/* Tableview delegate */
extension CustomTabVC: UITableViewDelegate {
    func viewController(for indexPath: IndexPath) -> UIViewController {
        // create the vc
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        
        // settings
        vc.object = (currentChild as! ObjectListVC).fetchedResultsController.object(at: indexPath)
        
        return vc
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch currentChild {
        case is ObjectListVC:
            // get the item/hero select
            objectForDetail = (currentChild as! ObjectListVC).fetchedResultsController.object(at: indexPath)

            // perform the segue
            performSegue(withIdentifier: "showDetail", sender: nil)
            
            // clear the selection
            tableView.deselectRow(at: indexPath, animated: false)
            
            
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
            let x = self.view.frame.origin.x
            let y = self.view.frame.origin.y
            let offset = keyboardSize.height - tabBar.frame.height + y
            self.view.frame = CGRect(x: x, y: y, width: self.view.frame.width, height: UIScreen.main.bounds.height - offset)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.height != UIScreen.main.bounds.height {
            // change the height of the view to the size of the available space
            let x = self.view.frame.origin.x
            let y = self.view.frame.origin.y
            let height = UIScreen.main.bounds.height - y
            self.view.frame = CGRect(x: x, y: y, width: self.view.frame.width, height: height)
        }
    }
}

extension CustomTabVC: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        // make sure our child is an ObjectListVC
        guard let child = currentChild as? ObjectListVC else { return nil }
        
        if let indexPath = child.tableView.indexPathForRow(at: location) {
            // this will blur everything else
            previewingContext.sourceRect = child.tableView.rectForRow(at: indexPath)
            return viewController(for: indexPath)
        }
        
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.showDetailViewController(viewControllerToCommit, sender: nil)
    }
}
























