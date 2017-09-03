//
//  DASeparatedView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-09-02.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class DASeparatedView: UIView {
    
    private(set) var titleLabel = DALabel(style: .subtitle)
    private var contentView = UIView()
    public let separatorView = DASeparatorView()
    
    private(set) var currentContentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        titleLabel.font = Fonts.subtitle.bold
        titleLabel.textAlignment = .center
        
        u0_addSubviews([titleLabel, contentView, separatorView])
        
        titleLabel.snp.makeConstraints() { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top).inset(Layout.defaultPadding)
        }
        
        contentView.snp.makeConstraints() { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(separatorView.snp.top)
        }
        
        separatorView.snp.makeConstraints() { make in
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    public func setContentView(_ view: UIView) {
        currentContentView?.removeFromSuperview()
        
        contentView.addSubview(view)
        view.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        currentContentView = view
    }
}
