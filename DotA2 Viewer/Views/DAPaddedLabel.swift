//
//  DAPaddedLabel.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DAPaddedLabel: UILabel {
    // MARK - Properties
    var insets: UIEdgeInsets? { didSet { drawText(in: self.frame) } }

    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets ?? UIEdgeInsets.zero))
    }
}
