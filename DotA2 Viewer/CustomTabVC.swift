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
        
        // hide the back button when pushing
        let btn = UIBarButtonItem()
        btn.title = ""
        navigationItem.backBarButtonItem = btn
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    /* Handles the user input when selecting the search button (scroll to search bar and  */
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        tableView.setContentOffset(CGPoint.zero, animated: true)
        tableView.searchBar.becomeFirstResponder()
    }
    
    /* Creates the detail view controller */
    fileprivate func createDetail(for object: ListObject) -> DADetailVC {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let hero = object as? Hero {
            let vc = sb.instantiateViewController(withIdentifier: "HeroDetailVC") as! HeroDetailVC
            vc.object = hero
            return vc
        }
        else {
            let item = object as! Item
            let vc = sb.instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailVC
            vc.object = item
            return vc
        }
    }
    
    /* Handles the move from hero <-> item */
    fileprivate func switchTableView() {
            self.tableView.reloadData()
            let ip = IndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: ip, at: .top, animated: false)
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
    /* helper function to configure the cell */
    fileprivate func configure(cell: DAMainTableViewCell, atIndexPath indexPath: IndexPath) {
        let obj = fetchedResultsController.object(at: indexPath)
        cell.circleImageView.image = obj.getImage()
        cell.mainLabel.text = obj.name
        cell.detailLabel.attributedText = obj.detailPretty
        
        cell.backgroundColor = UIColor.clear // for  iPad (bug < iOS 10)
    }
    
    /* lets tableview know how many sections there are */
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    /* lets tableview know how many rows are in the section */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    /* sets the index titles for the tableview index */
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController.sectionIndexTitles
    }
    
    /* configures the cell at the given index path */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DAMainTableViewCell
        configure(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    /* handles the selection of a cell */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = fetchedResultsController.object(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = createDetail(for: obj)
        showDetailViewController(vc, sender: self)
    }
}

// MARK - Keyboard handling
extension CustomTabVC {
    /* fixes tableview height when the keyboard will appear */
    func keyboardWillShow(notification: NSNotification) {
        if let offset = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: self.view.frame.height - offset)
        }
    }
    
    /* fixes tableview height when the keyboard disapears */
    func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - tabBar.frame.height)
        }
    }
}

// MARK - NSFRC Del
extension CustomTabVC: NSFetchedResultsControllerDelegate {
    /* this function is called when the NSFRC will be chaing its context */
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    /* This function is called when the NSFRC is changing its content */
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
    
    /* This function is called when the NSFRC is finished updating from the db */
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}


















































