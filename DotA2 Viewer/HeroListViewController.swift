//
//  HeroListViewController.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-03.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class HeroListViewController: ObjectListViewController, UITableViewDelegate {
    
    public weak var delegate: HeroListViewControllerDelegate?
    
    override var entity: String {
        return "Hero"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleName = "Heroes"
        tableView.delegate = self
    }
    
    override func configure(cell: DAMainTableViewCell, atIndexPath indexPath: IndexPath) {
        super.configure(cell: cell, atIndexPath: indexPath)
        
        guard let hero = fetchedResultsController.object(at: indexPath) as? Hero else {
            return
        }
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: hero.primaryAttribute.heroAttribute.rawValue + ".png")
        attachment.bounds = Layout.textAttachmentBounds(for: Fonts.subLabel)
        let attachmentAttString = NSAttributedString(attachment: attachment)
        
        let details = hero.misc.projectileSpeed == 0 ? " | Melee" : " | Ranged"
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
        
        guard let hero = fetchedResultsController.object(at: indexPath) as? Hero else {
            assertionFailure("FRC object is not hero type in HeroListViewController")
            return
        }
        
        delegate?.heroListViewController(self, didSelectHero: hero)
        
    }
}
