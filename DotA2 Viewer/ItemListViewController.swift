//
//  ItemListViewController.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-03.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class ItemListViewController: ObjectListViewController, UITableViewDelegate {
    
    public weak var delegate: ItemListViewControllerDelegate?
    
    override var entity: String {
        return "Item"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleName = "Items"
        tableView.delegate = self
    }
    
    override func configure(cell: DAMainTableViewCell, atIndexPath indexPath: IndexPath) {
        super.configure(cell: cell, atIndexPath: indexPath)
        
        guard let item = fetchedResultsController.object(at: indexPath) as? Item else {
            return
        }
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "coins.png")
        attachment.bounds = Layout.textAttachmentBounds(for: Fonts.subLabel)
        let attachmentAttString = NSAttributedString(attachment: attachment)
        
        let details = item.recipeCost == 0 ? " \(item.cost.uti_string(0))" : " \(item.cost.uti_string(0)) (\(item.recipeCost.uti_string(0)))"
        let attributes = [NSFontAttributeName: Fonts.subLabel]
        let detailsAttString = NSAttributedString(string: details, attributes: attributes)
        
        let attString = NSMutableAttributedString()
        attString.append(attachmentAttString)
        attString.append(detailsAttString)
        
        cell.detailLabel.attributedText = attString
        cell.backgroundColor = UIColor.clear
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let item = fetchedResultsController.object(at: indexPath) as? Item else {
            assertionFailure("FRC object is not item type in ItemListViewController")
            return
        }
        
        delegate?.itemListViewController(self, didSelectItem: item)
        
    }
}
