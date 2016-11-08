//
//  DAMainTabelView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-11-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import ChameleonFramework

class DAMainTabelView: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        // set the colour
        self.backgroundColor = UIColor.flatBlack()
        self.sectionIndexColor = UIColor.flatRed()
        self.sectionIndexTrackingBackgroundColor = UIColor.flatBlack()
        self.sectionIndexBackgroundColor = UIColor.flatBlack()
        self.rowHeight = 60
        
        // settings
        self.separatorInset = UIEdgeInsetsMake(0, self.rowHeight + kTableViewCellImageSpaceR + kTableViewCellImageSpaceL, 0, 0)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
