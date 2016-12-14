//
//  AbilitySubStackView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-12.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class AbilitySubStackView: UIStackView {
    // MARK - Properties
    /* Private */
    fileprivate var midSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        return sv
    }()
    fileprivate var sideSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    /* Public */
    var abilityImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    var cooldownLabel = DAIconLabel(style: .medium)
    var manaLabel = DAIconLabel(style: .medium)
    var typesLabel = DAMultiLineLabel(style: .medium)
    var summaryLabel = DAMultiLineLabel(style: .medium)
    var dataLabel = DAMultiLineLabel(style: .medium)
    var specialsLabel = DAMultiLineLabel(style: .medium)
    var modifiersLabel = DAMultiLineLabel(style: .medium)
    var notesSV = DAExpandableTextStackView(name: "Notes")
    
    // MARK - Initializers
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        setup()
        // add KVO for when ImageView image is set to remove if it's nil
        abilityImageView.addObserver(self, forKeyPath: "image", options: .new, context: nil)
        cooldownLabel.addObserver(self, forKeyPath: "normalText", options: .new, context: nil)
        manaLabel.addObserver(self, forKeyPath: "normalText", options: .new, context: nil)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        abilityImageView.removeObserver(self, forKeyPath: "image")
        cooldownLabel.removeObserver(self, forKeyPath: "normalText")
        manaLabel.removeObserver(self, forKeyPath: "normalText")
    }
    
    
    // MARK - Methods
    /* Private */
    fileprivate func setup() {
        // setup properties
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .equalSpacing
        
        // add subview
        let miniSV = UIStackView(arrangedSubviews: [cooldownLabel, manaLabel])
        miniSV.axis = .vertical
        miniSV.distribution = .fillProportionally
        sideSV.addArrangedSubviews(views: [typesLabel, miniSV])
        midSV.addArrangedSubviews(views: [abilityImageView, sideSV])
        self.addArrangedSubviews(views: [midSV, summaryLabel, dataLabel, specialsLabel, modifiersLabel, notesSV])
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {        
        if keyPath == "image" {
            // we want to fix up the view if there's no image
            if abilityImageView.image == nil {
                abilityImageView.removeFromSuperview()
                sideSV.axis = .horizontal
            }
        }
        
        if keyPath == "normalText" {
            if let lbl = object as? DAIconLabel {
                if lbl.normalText == "" {
                    lbl.removeFromSuperview()
                }
            }
        }
        
    }

}




































