//
//  ExpandableCellProtocol.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-07.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation

protocol ExpandableCellProtocol {
    var isExpanded: Bool { get set }
    func toggle()
}
