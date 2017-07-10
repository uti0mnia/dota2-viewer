//
//  UIView+AddSubviews.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-10.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

extension UIView {
    public func u0_addSubviews(_ views: [UIView?]) {
        for view in views {
            if let view = view {
                addSubview(view)
            }
        }
    }
}
