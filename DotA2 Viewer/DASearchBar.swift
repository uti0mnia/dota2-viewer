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
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func commonInit() {
        // set up style
        self.backgroundColor = UIColor.clear
        self.textField?.textColor = UIColor.flatWhite()
        self.tintColor = UIColor.flatWhite()
        self.searchBarStyle = .minimal
        self.showsCancelButton = true
    }
}
