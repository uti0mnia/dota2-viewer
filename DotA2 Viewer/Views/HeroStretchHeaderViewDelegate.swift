//
//  HeroStretchHeaderViewDelegate.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-11.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

public enum HeroDetailTab: Int {
    case detail = 0, ability, talent, misc
}

protocol HeroStretchHeaderViewDelegate: class {
    func heroStretchHeaderView(_ headerView: HeroStretchHeaderView, didTapTab tab: HeroDetailTab)
}
