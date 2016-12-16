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

class DAExpandableStackView: DAStackView, DAExpandableProtocol {
    // MARK - Properties
    
    /* Private */
    // the SV that holds the expanded/collapsed arrow and the top view
    fileprivate var topSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    fileprivate var arrowView: UIImageView = {
        let iv = UIImageView()
        let constraint = NSLayoutConstraint(item: iv, attribute: .width, relatedBy: .equal, toItem: iv, attribute: .height, multiplier: 1, constant: 0)
        iv.addConstraint(constraint)
        iv.contentMode = .left
        iv.image = #imageLiteral(resourceName: "sidearrow.png") // sidearrow.png
        return iv
    }()
    
    /* Internal */
    // the view that will always be seen
    internal var topView: UIView!
    internal var isExpanded = true
    // the view that is "inside " i.e that can be expanded
    internal var subView: UIView?
    
    /* Public */
    
    
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
    /* adds a subview to the stackview */
    func setSubview(_ view: UIView) {
        // reset subview
        subView?.removeFromSuperview()
        subView = view
        
        // set its status
        subView?.isHidden = !isExpanded
        configSubview()
        self.addArrangedSubview(subView!)
        
    }
    
    /* toggles the current state of the stack view */
    func toggle() {
        // only toggle if there's a subView
        guard subView != nil else {
            return
        }
        let rotation = isExpanded ? 0 : π / 2
        isExpanded = !isExpanded
        setSpacing(for: self)
        UIView.animate(withDuration: kExpansionTime) {
            self.arrowView.transform = CGAffineTransform(rotationAngle: rotation)
            self.subView?.isHidden = !self.isExpanded
            self.layoutIfNeeded()
        }
    }
    
    /* Forces the state of the expansion (true means expanded, false means not expanded) */
    func forceExpanded(_ expanded: Bool) {
        isExpanded = !expanded
        toggle()
    }
    
    /* sets up the stack view */
    internal func setup() {
        // settings
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .equalSpacing
        
        // set the top stack view
        topSV.addArrangedSubview(topView)
        self.addArrangedSubview(topSV)
        
        // add the side arrow (and rotate if necessary)
        let rotation = isExpanded ? π / 2 : 0
        arrowView.transform = CGAffineTransform(rotationAngle: rotation)
        topSV.insertArrangedSubview(arrowView, at: 0)
        
        // add the subview
        self.addArrangedSubviews(views: [subView])
        subView?.isHidden = !isExpanded
    }
    
    /* adds tap gesture that handles the expanding of the StackView */
    internal func addGestures() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(DAExpandableStackView.stackViewWasTapped(_:)))
        self.addGestureRecognizer(tap)
    }
    
    /* meant to handle the top button being tapped */
    @objc fileprivate func stackViewWasTapped(_ sender: Any) {
        toggle()
    }
    
    internal func configSubview() {
        guard subView != nil else {
            return
        }
        
        subView?.layoutMargins = UIEdgeInsetsMake(0, 8, 0, 8)
        if let sv = subView as? UIStackView {
            sv.isLayoutMarginsRelativeArrangement = true
        }
        
    }
    
    /* used to set the spacing when hidding the subviews so there are no issues */
    internal func setSpacing(for sv: UIStackView) {
        let space: CGFloat = isExpanded ? 8 : 0 // set the spacing required
        sv.spacing = space
        for view in sv.arrangedSubviews {
            if let sv = view as? UIStackView, view != topSV {
                if !(sv is DAExpandableStackView) {
                    setSpacing(for: sv)
                }
            }
        }
    }
}






































