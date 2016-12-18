//
//  DAMainTabelView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-11-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import ChameleonFramework

class DAMainTableView: UITableView {

    var searchBar: DASearchBar!
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.commonInit()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        // set the search bar
        searchBar = DASearchBar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 44))
        self.tableHeaderView = searchBar
        
        
        // set the colour
        self.backgroundColor = UIColor.flatBlack()
        self.sectionIndexColor = UIColor.flatRed()
        self.sectionIndexTrackingBackgroundColor = UIColor.flatBlack()
        self.sectionIndexBackgroundColor = UIColor.flatBlack()
    }

}
