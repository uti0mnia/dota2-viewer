//
//  HeroBasicViewDelegate.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-16.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

protocol HeroBasicViewDelegate: class {
    func heroBasicView(_ heroBasicView: HeroBasicView, didTapOnLabelWithType type: HeroBasicViewLabelType)
}
