//
//  CustomTabVC.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-19.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import CoreData

class CustomTabVC: DAUIViewController {
    
    // MARK - Outlets
    @IBOutlet weak var tableView: DAMainTableView!
    @IBOutlet weak var tabBar: DATabBar!
    
    // MARK - Properties
    fileprivate var titleView: DAMainLabel!
    fileprivate var selectedObject: ListObject!
    
    // MARK - Core Data
    fileprivate let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    private lazy var heroFRC: NSFetchedResultsController<ListObject> = {
        // properties
        let fetchRequest = NSFetchRequest<ListObject>(entityName: "Hero")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        
        // init the frc
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: self.context,
                                             sectionNameKeyPath: "firstLetter",
                                             cacheName: nil)
        frc.delegate = self
        return frc
        
    }()
    private lazy var itemFRC: NSFetchedResultsController<ListObject> = {
        // properties
        let request = NSFetchRequest<ListObject>(entityName: "Item")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        
        // init the frc
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: self.context,
                                             sectionNameKeyPath: "firstLetter",
                                             cacheName: nil)
        frc.delegate = self
        return frc
    }()
    fileprivate var fetchedResultsController: NSFetchedResultsController<ListObject> {
        get {
            return self.entity == "Hero" ? heroFRC : itemFRC
        }
    }
    fileprivate var entity = "Hero" { didSet { switchTableView() } }
    
    
    // MARK - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        
        // perform the fetch
        do {
            try heroFRC.performFetch()
            try itemFRC.performFetch()
        } catch {
            print("Error performing fetch: \(error.localizedDescription)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // nsnotification
        let ns = NotificationCenter.default
        ns.addObserver(self, selector: #selector(CustomTabVC.keyboardWillShow), name: .UIKeyboardDidShow, object: nil)
        ns.addObserver(self, selector: #selector(CustomTabVC.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func setup () {
        // configure the UI Elements
        tabBar.selectedItem = tabBar.items?.first!
        
        // title view
        titleView = DAMainLabel(style: .title)
        titleView.text = tabBar.selectedItem?.title
        titleView.sizeToFit()
        self.navigationItem.titleView = titleView
        
        // table view
        tableView.register(DAMainTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.searchBar.delegate = self
        
        // hide the back button when pushing
        let btn = UIBarButtonItem()
        btn.title = ""
        navigationItem.backBarButtonItem = btn

    }
    
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        tableView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    fileprivate func createDetail(for object: ListObject) -> DADetailVC? {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let hero = object as? Hero {
            let vc = sb.instantiateViewController(withIdentifier: "HeroDetailVC") as! HeroDetailVC
            vc.object = hero
            return vc
        }
        
        if let item = object as? Item {
            let vc = sb.instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailVC
            vc.object = item
            return vc
        }
        
        return nil
    }
    
    fileprivate func switchTableView() {
        tableView.searchBar.textField?.text = ""
        filterSeach(withText: "")
        self.tableView.reloadData()
        let ip = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: ip, at: .top, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // hero segue
        if segue.identifier == "showHero" {
            if let hero = selectedObject as? Hero {
                let vc = (segue.destination as! UINavigationController).topViewController as! HeroDetailVC
                vc.object = hero
            }
        }
        
        // item segue
        if segue.identifier == "showItem" {
            if let item = selectedObject as? Item {
                let vc = (segue.destination as! UINavigationController).topViewController as! ItemDetailVC
                vc.object = item
            }
        }
    }
}

// MARK - Tabbar Methods
extension CustomTabVC: UITabBarDelegate {
    /* This function handles the selection of the tab bar item */
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // change the entity depending on the selected item
        // only change entity if necessary
        if item.title! == "Heroes" {
            if entity != "Hero" {
                entity = "Hero"
                titleView.text = "Heroes"
            }
        } else {
            if entity != "Item" {
                entity = "Item"
                titleView.text = "Items"
            }
        }
    }
}

// MARK - TableView Methods
extension CustomTabVC: UITableViewDelegate, UITableViewDataSource {
    fileprivate func configure(cell: DAMainTableViewCell, atIndexPath indexPath: IndexPath) {
        let obj = fetchedResultsController.object(at: indexPath)
        cell.circleImageView.image = obj.getImage()
        cell.mainLabel.text = obj.name
        cell.detailLabel.attributedText = obj.detailPretty
        
        cell.backgroundColor = UIColor.clear // for  iPad (bug < iOS 10)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController.sectionIndexTitles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DAMainTableViewCell
        configure(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedObject = fetchedResultsController.object(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // for iPad
            let segue = selectedObject is Hero ? "showHero" : "showItem"
            self.performSegue(withIdentifier: segue, sender: self)
        } else {
            // for iPhone
            if let vc = createDetail(for: selectedObject) {
                showDetailViewController(vc, sender: self)
            }
        }
        
        
    }
}

// MARK - Search Bar Delegate methods
extension CustomTabVC: UISearchBarDelegate {
    fileprivate func filterSeach(withText text: String) {
        let predicate = (text != "") ? NSPredicate(format: "name CONTAINS %@", text) : NSPredicate(value: true)
        fetchedResultsController.fetchRequest.predicate = predicate
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            print("Error performing fetch: \(error.localizedDescription)")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterSeach(withText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.searchBar.textField?.text = ""
        filterSeach(withText: "")
        tableView.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableView.searchBar.resignFirstResponder()
    }
}

// MARK - Keyboard handling
extension CustomTabVC {
    func keyboardWillShow(notification: NSNotification) {
        if let offset = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: self.view.frame.height - offset)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - tabBar.frame.height)
        }
    }
}

// MARK - NSFRC Del
extension CustomTabVC: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .move:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

















































