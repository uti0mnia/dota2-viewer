//
//  ObjectCell.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-11-06.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class ObjectCell: UITableViewCell {

    @IBOutlet weak var objectImageView: UIImageView!
    @IBOutlet weak var objectName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // set the image to be a cicle
        objectImageView.layer.cornerRadius = objectImageView.frame.height / 2
        objectImageView.clipsToBounds = true
        
        // set the contour to be white
        objectImageView.layer.borderWidth = -3
        objectImageView.layer.borderColor = UIColor.white.cgColor
    }
    
}
