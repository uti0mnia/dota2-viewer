//
//  HeroStretchHeaderView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-11.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class HeroStretchHeaderView: UIView {
    weak var delegate: HeroStretchHeaderViewDelegate?
    
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
    
    // TODO: Make into swipe gesture.
    private var tapGesture: UITapGestureRecognizer!
    private var isCollapsed = false
    
    public var maxHeight: CGFloat = 300
    public var minHeight: CGFloat = 100
    
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
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnView(_:)))
        imageView.addGestureRecognizer(tapGesture)
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
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(stackView.snp.top)
        }
        
        stackView.snp.makeConstraints() { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        self.snp.makeConstraints() { make in
            make.height.equalTo(maxHeight)
        }
    }
    
    @objc private func didTapOnView(_ sender: UITapGestureRecognizer) {
        print("Tapped on view!")
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let tab = HeroDetailTab(rawValue: sender.tag) else {
            assertionFailure("HeroStretchHeaderView buttons not configured properly")
            return
        }
        
        delegate?.heroStretchHeaderView(self, didTapTab: tab)
    }
    
}
