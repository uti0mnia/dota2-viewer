//
//  DAExpandableStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

protocol DAExpandableProtocol {
    var isExpanded: Bool { get set }
    func toggle()
}

class DAExpandableStackView: UIStackView, DAExpandableProtocol {
    // MARK - Properties
    /* Internal */
    internal var topView: UIView!
    internal var isExpanded = true
    
    /* Public */
    var subView: UIView?
    
    // MARK - Initializers
    init(topView: UIView, subView: UIView?, expanded: Bool = true, frame: CGRect = CGRect()) {
        // properties
        self.topView = topView
        self.subView = subView
        self.isExpanded = expanded
        
        // super init
        super.init(frame: frame)
        
        // setup the stackView
        setup()
        setSpacing(for: self)
        addGestures()
    }
    
    /* should only be initialized through code due to the optional subview meant for lazy loading */
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Methods
    /* sets up the stack view */
    internal func setup() {
        // settings
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillProportionally
        
        // set the main label
        self.addArrangedSubview(topView)
        
        // add the subview
        self.addArrangedSubviews(views: [subView])
        subView?.isHidden = !isExpanded
    }
    
    internal func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(DAExpandableStackView.stackViewWasTapped(_:)))
        self.addGestureRecognizer(tap)
    }
    
    /* meant to handle the top button being tapped */
    @objc fileprivate func stackViewWasTapped(_ sender: Any) {
        toggle()
    }
    
    /* toggles the current state of the stack view */
    func toggle() {
        isExpanded = !isExpanded
        setSpacing(for: self)
        UIView.animate(withDuration: kExpansionTime) {
            self.subView?.isHidden = !self.isExpanded
            self.layoutIfNeeded()
        }
    }
    
    /* used to set the spacing when hidding the subviews so there are no issues */
    internal func setSpacing(for sv: UIStackView) {
        let space: CGFloat = isExpanded ? 8 : 0 // set the spacing required
        sv.spacing = space
        for view in sv.arrangedSubviews {
            if let sv = view as? UIStackView {
                setSpacing(for: sv)
            }
        }
    }
}






































