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

    public var searchBar: DASearchBar!
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        commonInit()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        // Set the search bar.
        searchBar = DASearchBar(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 44))
        searchBar.autoresizingMask = [.flexibleWidth]
        tableHeaderView = searchBar
        
        // Set the colour.
        backgroundColor = Colours.primaryColour
        sectionIndexColor = Colours.secondaryColour
        sectionIndexTrackingBackgroundColor = Colours.primaryColour
        sectionIndexBackgroundColor = Colours.primaryColour
    }

}
