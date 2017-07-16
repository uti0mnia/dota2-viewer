//
//  DAIconLabel.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-15.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

public enum DAIconLabelViewIconPosition {
    case left, right
}

class DAIconLabelView: UIView {
    
    private var imageView = UIImageView()
    private(set) var label = DALabel(style: .text)
    
    public var icon: UIImage? {
        didSet {
            imageView.image = icon
        }
    }
    public var iconPadding: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    public var iconPosition: DAIconLabelViewIconPosition = .left {
        didSet {
            setNeedsLayout()
        }
    }
    public var iconSize: CGSize = CGSize.zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        clipsToBounds = true
        addSubview(label)
        addSubview(imageView)
        
        label.numberOfLines = 0
        
        imageView.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        if icon == nil || iconSize == CGSize.zero {
            label.frame = bounds
        } else {
            switch iconPosition {
            case .left:
                // Place the icon so the middle vertical axis are aligned.
                let imageX: CGFloat = 0
                let imageY: CGFloat = (bounds.height - iconSize.height) / 2
                imageView.frame = CGRect(x: imageX, y: imageY, width: iconSize.width, height: iconSize.height)
                
                let labelX: CGFloat = iconSize.width + iconPadding
                let labelY: CGFloat = 0
                let width: CGFloat = bounds.width - iconSize.width
                label.frame = CGRect(x: labelX, y: labelY, width: width, height: bounds.height)
            case .right:
                // Place the icon so the middle vertical axis are aligned.
                let imageX: CGFloat = bounds.width - iconSize.width
                let imageY: CGFloat = (bounds.height - iconSize.height) / 2
                imageView.frame = CGRect(x: imageX, y: imageY, width: iconSize.width, height: iconSize.height)
                
                let labelX: CGFloat = 0
                let labelY: CGFloat = 0
                let width: CGFloat = bounds.width - iconSize.width - iconPadding
                label.frame = CGRect(x: labelX, y: labelY, width: width, height: bounds.height)
            }
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var width = iconSize.width + iconPadding
        let remainingWidth = size.width - width
        
        // If the width is too small for the image.
        if remainingWidth < 0 {
            return size
        }
        
        let labelSize = label.sizeThatFits(CGSize(width: remainingWidth, height: size.height))
        width += labelSize.width
        
        return CGSize(width: width, height: size.height)
    }
}
