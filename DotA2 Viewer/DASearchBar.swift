//
//  DASearchBar.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-11-12.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DASearchBar: UISearchBar {

    var textField: UITextField? {
        get {
            return self.value(forKey: "searchField") as? UITextField
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        // set up style
        self.backgroundColor = UIColor.clear
        self.textField?.textColor = UIColor.flatWhite()
        self.tintColor = UIColor.flatWhite()
        self.searchBarStyle = .minimal
    }
}
