//
//  ItemBuildStackView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-25.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class RecipeBuildView: UIStackView {
    
    public weak var delegate: RecipeBuildViewDelegate?
    
    public var itemNames: [String]? {
        didSet {
            recipeParts.forEach({ $0.removeFromSuperview() })
            topLabel.isHidden = true
            
            guard let itemNames = itemNames, itemNames.count > 0 else {
                return
            }
            
            topLabel.isHidden = false
            insertArrangedSubview(topLabel, at: 0)
            
            for index in 0..<itemNames.count {
                let name = itemNames[index]
                
                if index >= recipeParts.count {
                    recipeParts.append(createRecipePart())
                }
                
                recipeParts[index].itemName = name
                stackView.addArrangedSubview(recipeParts[index])
            }
        }
    }
    
    public var topLabelText: String? {
        didSet {
            topLabel.text = topLabelText
        }
    }
    
    private var recipeParts = [RecipePart]()
    private var stackView = UIStackView()
    private var topLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        axis = .vertical
        distribution = .fillProportionally
        spacing = 8
        
        stackView.distribution = .fillEqually
        
        uti_addArrangedSubviews(views: [topLabel, stackView])
    }
    
    private func createRecipePart() -> RecipePart {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnRecipePart(_:)))
        
        let recipePart = RecipePart()
        recipePart.isUserInteractionEnabled = true
        recipePart.addGestureRecognizer(tap)
        return recipePart
    }
    
    @objc private func didTapOnRecipePart(_ sender: UITapGestureRecognizer) {
        guard let recipePart = sender.view as? RecipePart else {
            print("tap gesture not configured properly")
            return
        }
        
        delegate?.recipeBuildView(self, didSelectItemWithName: recipePart.itemName)
    }
}
