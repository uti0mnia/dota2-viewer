//
//  ObjectHeaderView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-30.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class ObjectHeaderView: UIView {
    
    public static let maximumHeight: CGFloat = 250
    private static let resizeToMinThreshhold: CGFloat = 100
    private static let resizeToMaxThreshhold: CGFloat = 120
    private static let resizeTime: TimeInterval = 0.4
    
    public var imageView: UIImageView = {
        let iv = UIImageView()
        
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    public var stackView = UIStackView()
    
    public var minimumHeight: CGFloat {
        return stackView.bounds.height + 64 // UINavigationBar height
    }
    
    public var shouldShowButtons = true {
        didSet {
            if oldValue == shouldShowButtons {
                return
            }
            
            if shouldShowButtons {
                addSubview(stackView)
            } else {
                stackView.removeFromSuperview()
            }
            
            setNewConstraints()
        }
    }
    
    private var heightBeforePan: CGFloat = ObjectHeaderView.maximumHeight
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        initViews()
        addConstraints()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPanOnView(_:)))
        self.addGestureRecognizer(pan)
    }
    
    public func initViews() {
        stackView.distribution = .fillEqually
        
        uti_addSubviews([imageView, stackView])
        
    }
    
    private func addConstraints() {
        imageView.snp.makeConstraints() { make in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(stackView.snp.top)
        }
        
        stackView.snp.makeConstraints() { make in
            make.left.bottom.right.equalTo(self)
        }
        
        self.snp.makeConstraints() { make in
            make.height.equalTo(ObjectHeaderView.maximumHeight)
        }
        
    }
    
    private func setNewConstraints() {
        imageView.snp.removeConstraints()
        stackView.snp.removeConstraints()
        
        imageView.snp.makeConstraints() { make in
            make.left.top.right.equalTo(self)
            if shouldShowButtons {
                make.bottom.equalTo(stackView.snp.top)
            } else {
                make.bottom.equalTo(self)
            }
        }
        
        if shouldShowButtons {
            stackView.snp.makeConstraints() { make in
                make.left.bottom.right.equalTo(self)
            }
        }
    }
    
    @objc public func didPanOnView(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            heightBeforePan = self.bounds.height
        case .changed:
            let translate = gesture.translation(in: self).y
            var newHeight = bounds.height + translate
            gesture.setTranslation(CGPoint(), in: self)
            
            if newHeight < minimumHeight {
                newHeight = minimumHeight
            }
            
            self.snp.updateConstraints() { make in
                make.height.equalTo(newHeight)
            }
        case .ended, .cancelled:
            if bounds.height < minimumHeight {
                animateToMinSize()
            }
            if bounds.height > ObjectHeaderView.maximumHeight {
                animateToMaxSize()
            }
        default:
            break
        }
    }
    
    public func animateToMinSize() {
        self.snp.updateConstraints() { make in
            make.height.equalTo(minimumHeight)
        }
        superview?.setNeedsLayout()
        
        UIView.animate(withDuration: ObjectHeaderView.resizeTime) {
            self.superview?.layoutIfNeeded()
        }
    }
    
    public func animateToMaxSize() {
        self.snp.updateConstraints() { make in
            make.height.equalTo(ObjectHeaderView.maximumHeight)
        }
        superview?.setNeedsLayout()
        
        UIView.animate(withDuration: ObjectHeaderView.resizeTime) {
            self.superview?.layoutIfNeeded()
        }
    }
    
}
