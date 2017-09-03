//
//  AbilitySpecialView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-09-02.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class AbilitySpecialView: UIView {
    
    private class AbilitySpecialImageView: UIImageView {
        public var abilitySpecial: String?
        
    }
    
    private static var spacing: CGFloat {
        let wanted: CGFloat = 10
        return wanted  - (Layout.abilitySpecialViewSize.width - Layout.abilitySpecialImageSize.width)
    }
    
    private var imageViews = [AbilitySpecialImageView]()
    
    public weak var delegate: AbilitySpecialViewDelegate?
    
    public func setSpecials(_ specials: [String]?) {
        imageViews.forEach() { $0.removeFromSuperview() }
        
        guard let specials = specials else {
            return
        }
        
        let newImageViewCount = specials.count - imageViews.count
        if newImageViewCount > 0 {
            for _ in 0..<newImageViewCount {
                let iv = AbilitySpecialImageView()
                iv.contentMode = .scaleAspectFit
                iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnImageView(_:))))
                iv.isUserInteractionEnabled = true
                imageViews.append(iv)
            }
        }
        
        assert(specials.count <= imageViews.count, "Image Views not configured properly.")
        
        for index in 0..<specials.count {
            let special = specials[index]
            let imageView = imageViews[index]
            imageView.image = UIImage(named: special + ".png")
            imageView.abilitySpecial = special
            addSubview(imageView)
        }
        
        setNeedsLayout()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var currentX = bounds.width
        for imageView in imageViews {
            let width = Layout.abilitySpecialViewSize.width
            let x = currentX - width
            let frame = CGRect(x: x, y: 0, width: width, height: bounds.height)
            imageView.frame = frame
            
            let dx = (Layout.abilitySpecialViewSize.width - Layout.abilitySpecialImageSize.width) / 2
            let dy = (Layout.abilitySpecialViewSize.height - Layout.abilitySpecialImageSize.height) / 2
            imageView.bounds = imageView.frame.insetBy(dx: dx, dy: dy)
            
            currentX -= (width + AbilitySpecialView.spacing)
        }
    }
    
    @objc private func didTapOnImageView(_ sender: UITapGestureRecognizer) {
        guard let special = (sender.view as? AbilitySpecialImageView)?.abilitySpecial else {
            return
        }
        
        delegate?.abilitySpecialView(self, didTapOnSpecial: special)
    }
    
}
