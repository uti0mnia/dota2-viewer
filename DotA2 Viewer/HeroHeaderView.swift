//
//  HeroStretchHeaderView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-11.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class HeroHeaderView: UIView {
    
    private static let minimumHeight: CGFloat = 100
    private static let maximumHeight: CGFloat = 250
    private static let resizeToMinThreshhold: CGFloat = 180
    private static let resizeToMaxThreshhold: CGFloat = 120
    private static let resizeTime: TimeInterval = 0.4
    
    weak var delegate: HeroHeaderViewDelegate?
    
    public var imageView: UIImageView = {
        let iv = UIImageView()
        
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    private var stackView = UIStackView()
    public var detailsButton = UIButton()
    public var abilitiesButton = UIButton()
    public var talentsButton = UIButton()
    public var miscButton = UIButton()
    
    private var heightBeforePan: CGFloat = HeroHeaderView.maximumHeight
    
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
        imageView.addGestureRecognizer(pan)
    }
    
    private func initViews() {
        stackView.uti_addArrangedSubviews(views: [detailsButton, abilitiesButton, talentsButton, miscButton])
        stackView.distribution = .fillEqually
        
        uti_addSubviews([imageView, stackView])
        
        detailsButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        detailsButton.setTitle("Details", for: .normal)
        detailsButton.tag = 0
        
        abilitiesButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        abilitiesButton.setTitle("Abilities", for: .normal)
        abilitiesButton.tag = 1
        
        talentsButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        talentsButton.setTitle("Talents", for: .normal)
        talentsButton.tag = 2
        
        miscButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        miscButton.setTitle("Miscellaneous", for: .normal)
        miscButton.tag = 3
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
            make.height.equalTo(HeroHeaderView.maximumHeight)
        }
        
    }
    
    @objc private func didPanOnView(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            heightBeforePan = self.bounds.height
        case .changed:
            let translate = gesture.translation(in: self).y
            let newHeight = bounds.height + translate
            gesture.setTranslation(CGPoint(), in: self)
            
            self.snp.updateConstraints() { make in
                make.height.equalTo(newHeight)
            }
        case .ended, .cancelled:
            if bounds.height < HeroHeaderView.minimumHeight || heightBeforePan >= HeroHeaderView.resizeToMinThreshhold && bounds.height < HeroHeaderView.resizeToMinThreshhold {
                animateToMinSize()
            }
            if bounds.height > HeroHeaderView.maximumHeight || heightBeforePan <= HeroHeaderView.resizeToMaxThreshhold && bounds.height > HeroHeaderView.resizeToMaxThreshhold {
                animateToMaxSize()
            }
        default:
            break
        }
    }
    
    private func animateToMinSize() {
        self.snp.updateConstraints() { make in
            make.height.equalTo(HeroHeaderView.minimumHeight)
        }
        superview?.setNeedsLayout()

        UIView.animate(withDuration: HeroHeaderView.resizeTime) {
            self.superview?.layoutIfNeeded()
        }
    }
    
    private func animateToMaxSize() {
        self.snp.updateConstraints() { make in
            make.height.equalTo(HeroHeaderView.maximumHeight)
        }
        superview?.setNeedsLayout()
        
        UIView.animate(withDuration: HeroHeaderView.resizeTime) {
            self.superview?.layoutIfNeeded()
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let tab = HeroDetailTab(rawValue: sender.tag) else {
            assertionFailure("\(String(describing: self)) buttons not configured properly")
            return
        }
        
        delegate?.heroHeaderView(self, didTapTab: tab)
    }
    
}
