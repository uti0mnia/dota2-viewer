//
//  ItemBuildStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-25.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class ItemBuildView: UIView {
    
    public var imageNames: [String]? {
        didSet {
            imageViews.forEach({ $0.removeFromSuperview() })
            
            guard let imageNames = imageNames else {
                topLabel.text = nil
                return
            }
            
            topLabel.text = topLabelText
            
            for index in 0..<imageNames.count {
                let name = imageNames[index]
                
                guard let image = UIImage(named: name) else {
                    print("No image found with name '\(name)'")
                    return
                }
                
                if index > imageViews.count {
                    imageViews.append(ItemBuildView.createImageView())
                }
                
                imageViews[index].image = image
                stackView.addArrangedSubview(imageViews[index])
            }
        }
    }
    
    public var topLabelText: String? {
        didSet {
            topLabel.text = topLabelText
        }
    }
    
    private var imageViews = [UIImageView]()
    private var stackView = UIStackView()
    private var topLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        stackView.distribution = .fillEqually
        
        uti_addSubviews([topLabel, stackView])
        
        topLabel.snp.makeConstraints() { make in
            make.left.top.right.equalTo(self).inset(8)
            make.bottom.equalTo(stackView.snp.top).offset(-8)
        }
        
        stackView.snp.makeConstraints() { make in
            make.left.bottom.right.equalTo(self).inset(8)
        }
    }
    
    private static func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
