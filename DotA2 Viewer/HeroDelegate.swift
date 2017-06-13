//
//  ObserverPatter.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-31.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

protocol HeroDelegate: class {
    func heroDidUpdateLevel()
}
