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

class ObjectListVC: UIViewController {
	
	/* Properties */
	var tableView: UITableView!
	var collectionView: UICollectionView!
	fileprivate let itemSegueID = "segueItemDetail"
	fileprivate let heroSegueID = "segueHeroDetail"
	
	var entity: String { get { return "ListObject" } }
    let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    lazy var fetchedResultsController: NSFetchedResultsController<ListObject> = {
        let fetchRequest = NSFetchRequest<ListObject>(entityName: self.entity)
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        frc.delegate = self
        
        return frc
    }()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// configure table view
		configureTableView()
		
		// frc
		do {
			try fetchedResultsController.performFetch()
		} catch {
			print("Error performing fetch: \(error.localizedDescription)")
		}
    }
	
	/* Mehtods */
	// private methods
	
	private func configureTableView() {
		tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		self.view.addSubview(tableView)
		
		// constraints
		let views: [String: Any] = ["tableView": tableView]
		var constrainsts = [NSLayoutConstraint]()
		let hlayout = NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|",
		                                             options: [],
		                                             metrics: nil,
		                                             views: views)
		let vlayout = NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|",
		                                             options: [],
		                                             metrics: nil,
		                                             views: views)
		constrainsts += hlayout
		constrainsts += vlayout
		NSLayoutConstraint.activate(constrainsts)
	}
	
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
	
	

}

/* TableView Delegate */
extension ObjectListVC: UITableViewDataSource {
	
	// helper functions
	func configureCell(cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
		let obj = fetchedResultsController.object(at: indexPath)
		cell.imageView?.image = obj.objectImage()
		cell.textLabel?.text = obj.name
	}
	
	// delegate methods
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
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
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
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
			let cell = tableView.cellForRow(at: indexPath!)
			configureCell(cell: cell!, atIndexPath: indexPath!)
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

/* CollectionView Delegate */
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




































