//
//  UITableView+ReloadVisibleCells.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-02.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

extension UITableView {
    public func reloadVisibleIfPossible(with animation: UITableViewRowAnimation) {
        beginUpdates()
        if let indexPaths = self.indexPathsForVisibleRows {
            reloadRows(at: indexPaths, with: animation)
        } else {
            self.reloadData()
        }
        endUpdates()
    }
}
