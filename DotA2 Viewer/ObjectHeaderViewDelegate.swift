//
//  ObjectHeaderViewDelegate.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-02.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

protocol ObjectHeaderViewDelegate: class {
    func objectHeaderView(_ objectHeaderView: ObjectHeaderView, didChangeImageHeightTo height: CGFloat)
}
