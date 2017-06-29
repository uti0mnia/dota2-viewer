//
//  RecipeBuildViewDelegate.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-27.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

protocol RecipeBuildViewDelegate: class {
    func recipeBuildView(_ recipeBuildView: RecipeBuildView, didSelectItemWithName name: String?)
}
