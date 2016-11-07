//
//  ViewController.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-06.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import CoreData
//TODO: make a collection view

class ObjectListVC: MyTableVC {
	
	/* Properties */
	var collectionView: UICollectionView!
	
	var entity: String { get { return "ListObject" } }
    let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    lazy var fetchedResultsController: NSFetchedResultsController<ListObject> = {
        let fetchRequest = NSFetchRequest<ListObject>(entityName: self.entity)
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.context,
            sectionNameKeyPath: "firstLetter", // for the indexing
            cacheName: nil)
        
        frc.delegate = self
        
        return frc
    }()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// configure table view
		tableView.dataSource = self
		tableView.register(DAMainTableViewCell.self, forCellReuseIdentifier: "objectCell")
		
		// frc
		do {
			try fetchedResultsController.performFetch()
		} catch {
			print("Error performing fetch: \(error.localizedDescription)")
		}
    }
	
	/* Mehtods */
	// private methods
	
	private func configureCollectionView() {
		let layout = UICollectionViewFlowLayout()
		collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(SimpleCVCell.self, forCellWithReuseIdentifier: "cell")
		collectionView.delegate = self
		collectionView.dataSource = self
		self.view.addSubview(collectionView)
		
		//constraints
		let views: [String: Any] = ["collectionView": collectionView]
		var constrainsts = [NSLayoutConstraint]()
		let hlayout = NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|",
		                                             options: [],
		                                             metrics: nil,
		                                             views: views)
		let vlayout = NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]|",
		                                             options: [],
		                                             metrics: nil,
		                                             views: views)
		constrainsts += hlayout
		constrainsts += vlayout
		NSLayoutConstraint.activate(constrainsts)
	}
	
	func clearFilter() {
		// reset the frc
		let predicate = NSPredicate(value: true)
		fetchedResultsController.fetchRequest.predicate = predicate
		do {
			try fetchedResultsController.performFetch()
			tableView.reloadData()
		} catch {
			print("Error performing fetch: \(error.localizedDescription)")
		}
	}
	
	

}

/* TableView Delegate */
extension ObjectListVC: UITableViewDataSource {
	
	// helper functions
	func configureCell(cell: DAMainTableViewCell, atIndexPath indexPath: IndexPath) {
		let obj = fetchedResultsController.object(at: indexPath)
		cell.objectName.text = obj.name
		
		// set the image
		cell.objectImageView.image = obj.objectImage()
		cell.objectImageView.sizeToFit()
	}
	
	// delegate methods
	func numberOfSections(in tableView: UITableView) -> Int {
		if let sections = fetchedResultsController.sections {
			return sections.count
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let sections = fetchedResultsController.sections {
			let currentSection = sections[section]
			return currentSection.numberOfObjects
		}
		
		return 0
	}
	
	func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		return fetchedResultsController.sectionIndexTitles
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "objectCell", for: indexPath) as! DAMainTableViewCell
		configureCell(cell: cell, atIndexPath: indexPath)
		return cell
		
	}
	
}

/* Fetched Results Controller */
extension ObjectListVC: NSFetchedResultsControllerDelegate {
	// this will most likely be useful in the future when we move to cloud db
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
			let cell = tableView.cellForRow(at: indexPath!) as! DAMainTableViewCell
			configureCell(cell: cell, atIndexPath: indexPath!)
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

/* CollectionView Delegate  TODO*/
extension ObjectListVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	func configure(cell: SimpleCVCell, atIndexPath indexPath: IndexPath) {
		let obj = fetchedResultsController.object(at: indexPath)
		cell.simpleView.imageView.image = obj.objectImage()
		cell.simpleView.textLabel.text = obj.name
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		if let sections = fetchedResultsController.sections {
			return sections.count
		}
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if let sections = fetchedResultsController.sections {
			let currentSection = sections[section]
			return currentSection.numberOfObjects
		}
		
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SimpleCVCell
		configure(cell: cell, atIndexPath: indexPath)
		return cell
	}
}

extension ObjectListVC: UISearchBarDelegate {
	// stop editing when cancel/search is pressed
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
	
	func cancelButtonPressed() {
		if let parentVC = self.parent as? CustomTabVC {
			parentVC.searchBar.text = "" // clear text
			
			clearFilter()
			
			// hide the search bar
			parentVC.hideSearchBar()
		}
	}
	
	// filtering logic
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		// create the predicate
		var predicate: NSPredicate!
		if searchText == "" {
			predicate = NSPredicate(value: true)
		} else {
			predicate = NSPredicate(format: "name contains[c] %@", searchText)
		}
		
		// set the predicate
		fetchedResultsController.fetchRequest.predicate = predicate
		
		// perform fetch
		do {
			try fetchedResultsController.performFetch()
			tableView.reloadData()
		} catch {
			print("Error performing fetch:\(error.localizedDescription)")
		}
	}
	
}


































