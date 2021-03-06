//
//  ObjectListViewController.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-03.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import CoreData

class ObjectListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    private static let mainCellRuseIdendifier = "mainCell"
    
    private(set) var tableView = DAMainTableView()
    
    private var titleLabel = DALabel(style: .title)
    public var titleName: String? {
        didSet {
            titleLabel.text = titleName
            titleLabel.sizeToFit()
        }
    }
    
    public var entity: String {
        return "Object"
    }
    private(set) var fetchedResultsController: NSFetchedResultsController<Object>!
    
    override func willMove(toParentViewController parent: UIViewController?) {
        parent?.navigationItem.titleView = titleLabel
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        titleLabel.u0_addWhiteTextShadow()
        
        let request = NSFetchRequest<Object>(entityName: entity)
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: CoreDataManager.shared.sharedContext,
                                             sectionNameKeyPath: "firstLetter",
                                             cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error performing fetch: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.flatBlackDark
        
        // Table view.
        tableView.frame = view.bounds
        tableView.backgroundColor = Colours.primaryColour
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(DAMainTableViewCell.self, forCellReuseIdentifier: ObjectListViewController.mainCellRuseIdendifier)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.searchBar.delegate = self
        
        view.addSubview(tableView)
    }
    
    public func configure(cell: DAMainTableViewCell, atIndexPath indexPath: IndexPath) {
        let obj = fetchedResultsController.object(at: indexPath)
        cell.mainLabel.text = obj.name
        cell.circleImageView.image = UIImage(named: obj.thumbnailName)
        //DispatchQueue.global(qos: .userInteractive).async {
          //  let image = UIImage(named: obj.thumbnailName)
            
            //DispatchQueue.main.async {
              //  if self.tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
                //    let cell = self.tableView.cellForRow(at: indexPath) as! DAMainTableViewCell
                  //  cell.circleImageView.image = image
            //    }
          //  }
        //}
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ObjectListViewController.mainCellRuseIdendifier, for: indexPath) as! DAMainTableViewCell
        configure(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController.sectionIndexTitles
    }
    
    
    // MARK: - UISearchBarDelegate
    
    private func filterSeach(withText text: String) {
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
