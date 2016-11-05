//
//  File.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class SimpleCVCell: UICollectionViewCell {
    var simpleView: SimpleView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        simpleView = SimpleView()
        simpleView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(simpleView)
        
        let views: [String: Any] = ["view": simpleView]
        var constraints = [NSLayoutConstraint]()
        let hlayout = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                     options: [],
                                                     metrics: nil,
                                                     views: views)
        let vlayout = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                     options: [],
                                                     metrics: nil,
                                                     views: views)
        constraints += hlayout
        constraints += vlayout
        NSLayoutConstraint.activate(constraints)
        
        self.backgroundView = UIView()
    }
}


class SimpleView: UIView {
    
    var stackView: UIStackView!
    var imageView: UIImageView!
    var textLabel: UILabel!
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        // initialize the items
        imageView = UIImageView()
        textLabel = UILabel()
        
        // stack view
        stackView = UIStackView(arrangedSubviews: [imageView, textLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8.0
        stackView.distribution = UIStackViewDistribution.fillProportionally
    }
    
}
