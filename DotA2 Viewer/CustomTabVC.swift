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
    fileprivate var titleView: DAMainLabel! { didSet { self.navigationItem.titleView = titleView } }
    fileprivate var selectedObject: ListObject!
    
    // MARK - Core Data
    fileprivate let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    private var _fetchedResultsController: NSFetchedResultsController<ListObject>?
    fileprivate var fetchedResultsController: NSFetchedResultsController<ListObject> {
        get {
            if _fetchedResultsController != nil {
                return _fetchedResultsController!
            } else {
                // set properties
                let fetchRequest = NSFetchRequest<ListObject>(entityName: self.entity)
                let sort = NSSortDescriptor(key: "name", ascending: true)
                fetchRequest.sortDescriptors = [sort]
                
                // init the NSFRC
                let frc = NSFetchedResultsController(
                    fetchRequest: fetchRequest,
                    managedObjectContext: self.context,
                    sectionNameKeyPath: nil, // for the indexing
                    cacheName: nil)
                
                frc.delegate = self
                _fetchedResultsController = frc
                
                return frc
            }
        }
    }
    fileprivate var entity = "Hero" {
        didSet {
            _fetchedResultsController = nil
            tableView.reloadData()
        }
    }
    
    
    // MARK - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // loggin
        let fetch = NSFetchRequest<ListObject>(entityName: "Hero")
        do {
            let entities = try context.fetch(fetch)
            print("ENTITIES: \(entities.count)")
        } catch {
            print("error: \(error.localizedDescription)")
        }
        
        // configure the UI Elements
        titleView = DAMainLabel(style: .title)
        titleView.text = tabBar.selectedItem?.title
        titleView.sizeToFit()
        
        // hide the back button when pushing
        let btn = UIBarButtonItem()
        btn.title = ""
        navigationItem.backBarButtonItem = btn
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // make sure we have a selected item
        guard selectedObject != nil else {
            return
        }
        
        // the showDetail segues
        if segue.identifier == "showDetail" {
            if let vc = (segue.destination as? UINavigationController)?.viewControllers.first as? DetailVC {
                vc.object = selectedObject
            }
            tableView.searchBar.text = ""
        }
    }
    
    
    /* Handles the user input when selecting the search button (scroll to search bar and  */
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        tableView.setContentOffset(CGPoint.zero, animated: true)
        tableView.searchBar.becomeFirstResponder()
    }
}

/* Tab bar delegate */
extension CustomTabVC: UITabBarDelegate {
    /* This function handles the selection of the tab bar item */
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // change the entity depending on the selected item
        // only change entity if necessary
        if item.title! == "Heroes" {
            if entity != "Hero" {
                entity = "Hero"
            }
        } else {
            if entity != "Item" {
                entity = "Item"
            }
        }
    }
}

/* Tableview delegate */
extension CustomTabVC: UITableViewDelegate, UITableViewDataSource {
    /* helper function to configure the cell */
    fileprivate func configure(cell: DAMainTableViewCell, atIndexPath indexPath: IndexPath) {
        let obj = fetchedResultsController.object(at: indexPath)
        cell.objectImageView.image = obj.getImage()
        cell.textLabel?.text = obj.name
    }
    
    /* lets tableview know how many sections there are */
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    /* lets tableview know how many rows are in the section */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    /* sets the index titles for the tableview index */
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController.sectionIndexTitles
    }
    
    /* configures the cell at the given index path */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "objectCell", for: indexPath) as! DAMainTableViewCell
        configure(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    /* handles the selection of a cell */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = fetchedResultsController.object(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

/* Keyboard Handling */
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

extension CustomTabVC: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath = tableView.indexPathForRow(at: location) {
            // this will blur everything else
            previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
            return nil
        }
        
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.showDetailViewController(viewControllerToCommit, sender: nil)
    }
}

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
            let cell = tableView.cellForRow(at: indexPath!) as! DAMainTableViewCell
            configure(cell: cell, atIndexPath: indexPath!)
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
























