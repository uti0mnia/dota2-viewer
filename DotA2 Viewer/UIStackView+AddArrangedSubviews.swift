//
//  UIStackView+AddArrangedSubviews.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-20.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

extension UIStackView {
    public func uti_addArrangedSubviews(views: [UIView?]) {
        for view in views {
            if view == nil { continue }
            self.addArrangedSubview(view!)
        }
    }
}
