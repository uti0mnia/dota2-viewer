//
//  AbilitySpecialViewDelegate.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-09-02.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

protocol AbilitySpecialViewDelegate: class {
    func abilitySpecialView(_ abilitySpecialView: AbilitySpecialView, didTapOnSpecial special: String)
}
