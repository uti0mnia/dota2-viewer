//
//  ItemHeaderViewDelegate.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-27.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

public enum ItemDetailTab: Int {
    case basic = 0, ability
}

protocol ItemHeaderViewDelegate: class {
    func itemHeaderViewDidTapOnImageView()
    func itemHeaderView(_ itemHeaderView: ItemHeaderView, didTapTab tab: ItemDetailTab)
}
