//
//  AbilityViewDelegate.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-09-02.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

protocol AbilityViewDelegate: class {
    func abilityView(_ abilityView: AbilityView, didTapOnSpecial special: String)
}
