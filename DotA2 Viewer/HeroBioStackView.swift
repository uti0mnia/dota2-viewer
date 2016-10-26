//
//  HeroBioStackView.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-26.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroBioStackView: UIStackView {

    var bioLabel: UILabel!
    
    func setStack() {
        bioLabel = MultiLineLabel()
        
        self.addArrangedSubview(bioLabel)
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillEqually
    }

}
