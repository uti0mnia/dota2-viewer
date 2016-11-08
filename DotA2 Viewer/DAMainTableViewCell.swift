//
//  DAObjectCell.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-11-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DAMainTableViewCell: UITableViewCell {
    
    var objectImageView: DACircleImageView = {
        let img = DACircleImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var objectName: DAMainLabel = {
        let lbl = DAMainLabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // add the views
        self.contentView.addSubview(objectImageView)
        self.contentView.addSubview(objectName)
        
        // set the layout
        let viewConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-spl-[img]-spr-[label]|",
                                                             options: .alignAllCenterY,
                                                             metrics: ["spl": kTableViewCellImageSpaceL, "spr": kTableViewCellImageSpaceR],
                                                             views: ["img": objectImageView, "label": objectName])
        
        let v1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(2)-[img]-(2)-|",
                                                options: [],
                                                metrics: nil,
                                                views: ["img": objectImageView])
        
        let v2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|",
                                               options: [],
                                               metrics: nil,
                                               views: ["label": objectName])
        
        self.contentView.addConstraints(viewConstraints + v1 + v2)
        
        // image constraint
        let constraint = NSLayoutConstraint(item: objectImageView, attribute: .width, relatedBy: .equal, toItem: objectImageView, attribute: .height, multiplier: 1, constant: 1)
        objectImageView.addConstraint(constraint)
        
        // set the colours
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

































