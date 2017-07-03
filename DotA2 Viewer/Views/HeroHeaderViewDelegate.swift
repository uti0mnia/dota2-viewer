//
//  HeroStretchHeaderViewDelegate.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-11.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

public enum HeroDetailTab: Int {
    case basic = 0, ability, talent, misc
}

protocol HeroHeaderViewDelegate: ObjectHeaderViewDelegate {
    func heroHeaderView(_ headerView: HeroHeaderView, didTapTab tab: HeroDetailTab)
}
