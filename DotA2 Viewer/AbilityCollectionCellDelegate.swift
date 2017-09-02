//
//  AbilityCollectionCellDelegate.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-09-02.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

protocol AbilityCollectionCellDelgate: class {
    func abilityCollectionCell(_ abilityCollectionCell: AbilityCollectionCell, didTapOnSpecial special: String)
}
