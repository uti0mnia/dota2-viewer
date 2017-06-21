//
//  DAObjectCell.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-11-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DAMainTableViewCell: UITableViewCell {
    // MARK - Properties
    /* Private */
    fileprivate var fullSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    fileprivate var rightSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .leading
        sv.distribution = .fillEqually
        return sv
    }()
    
    /* Public */
    var circleImageView = DARoundedImageView()
    var mainLabel = DAMainLabel(style: .medium)
    var detailLabel = DAMultiLineLabel(style: .small)
    
    // MARK - Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Methods
    fileprivate func setup() {
        // setup the stack views
        rightSV.uti_addArrangedSubviews(views: [mainLabel, detailLabel])
        fullSV.uti_addArrangedSubviews(views: [circleImageView, rightSV])
        self.contentView.addSubview(fullSV)
        
        // set up constraints
        let wConstraint = NSLayoutConstraint(item: circleImageView, attribute: .width, relatedBy: .equal, toItem: circleImageView, attribute: .height, multiplier: 1.3, constant: 0)
        let hConstraint = NSLayoutConstraint(item: circleImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)
        circleImageView.addConstraints([wConstraint, hConstraint])
        var constraints = createConstraints("V:|-[stackView]-|", views: ["stackView": fullSV])
        constraints += createConstraints("H:|-[stackView]-|", views: ["stackView": fullSV])
        self.contentView.addConstraints(constraints)
        
        // setup the separators
        self.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0)
        
    }
    
    fileprivate func createConstraints(_ format: String, views: [String: Any]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: views)
        
    }

}

































