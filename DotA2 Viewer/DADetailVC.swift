//
//  DetailVC.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DADetailVC: DAUIViewController {
    // MARK - Properties
    var object: ListObject!
    internal var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    internal lazy var titleLabel: DAMainLabel = {[unowned self] in
        let lbl = DAMainLabel(style: .large)
        lbl.text = self.object.name
        lbl.sizeToFit()
        return lbl
    }()
    
    // MARK - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        guard object != nil else { return }
        addSubviews()
        setup()
        
    }
    
    internal func addSubviews() {
        // colours
        self.view.backgroundColor = UIColor.flatBlack()
        
        // scrollview
        self.view.addSubview(scrollView)
        var constraints = [NSLayoutConstraint]()
        constraints += createConstraints(withVisual: "H:|[scrollView]|", withViews: ["scrollView": scrollView], options: .alignAllCenterX)
        constraints += createConstraints(withVisual: "V:|[scrollView]|", withViews: ["scrollView": scrollView], options: .alignAllCenterX)
        self.view.addConstraints(constraints)
    }
    
    internal func setup() {
        // navigation bar
        self.navigationItem.titleView = titleLabel
    }
    
    internal func insertAbilities(_ abilities: [AbilityModel], into abilitiesSV: AbilitiesStackView?) {
        // we want to load the abilities asynchronously
        for i in 0..<abilities.count {
            DispatchQueue.main.async {
                // create the ability model
                let abilityModel = abilities[i]
                
                // create the subview for the AbiltyStackView
                let subView = AbilitySubStackView()
                subView.abilityImageView.image = abilityModel.image
                subView.cooldownLabel.icon = UIImage(named: "cooldown.png")
                subView.cooldownLabel.text = abilityModel.cooldown
                subView.dataLabel.attributedText = abilityModel.dataPretty
                subView.manaLabel.icon = UIImage(named: "mana.png")
                subView.manaLabel.text = abilityModel.mana
                subView.modifiersLabel.text = abilityModel.modifiers.joined(separator: "\n")
                subView.notesSV.textLabel.text = abilityModel.notesPretty
                subView.specialsLabel.attributedText = abilityModel.specialDetailsPretty
                subView.summaryLabel.text = abilityModel.summary
                subView.typesLabel.attributedText = abilityModel.typesPrettyPrint
                
                // set the AbilitySV subview
                abilitiesSV?.subStackViews[i].nameLabel.text = abilityModel.name
                abilitiesSV?.subStackViews[i].specialsLabel.attributedText = abilityModel.specialsPretty
                abilitiesSV?.subStackViews[i].setSubview(subView)
            }
        }
    }
    
    internal func createConstraints(withVisual str: String, withViews views: [String: Any], options: NSLayoutFormatOptions = []) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: str, options: options, metrics: nil, views: views)
    }
    
    

}







































