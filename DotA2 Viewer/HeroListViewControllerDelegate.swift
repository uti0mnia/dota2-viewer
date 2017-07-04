//
//  HeroListViewControllerDelegate.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-03.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

protocol HeroListViewControllerDelegate: class {
    func heroListViewController(_ heroListViewController: HeroListViewController, didSelectHero hero: Hero)
}
