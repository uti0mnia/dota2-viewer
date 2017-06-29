//
//  ItemBasicVCDelegate.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-25.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

protocol ItemBasicViewControllerDelegate: class {
    func itemBasicViewController(_ itemBasicViewController: ItemBasicViewController, didSelectItem item: Item)
}
