//
//  AbilityViewController.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-22.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class AbilityViewController: UIViewController {
    
    private static let padding: CGFloat = 8
    
    public var ability: Ability? {
        didSet {
            guard let ability = ability else {
                return
            }
            
            if abilityView == nil {
                abilityView = AbilityView()
                
                scrollView.addSubview(abilityView!)
                
                abilityView?.snp.makeConstraints() { make in
                    make.left.top.right.bottom.equalTo(scrollView)
                    make.width.equalTo(scrollView.snp.width)
                }
            }
            
            abilityView?.name = ability.name
            abilityView?.specials = ability.specialIcons
            abilityView?.abilityImage = UIImage(named: ability.imageName)
            abilityView?.abilityDescription = ability.descrip
            abilityView?.types = ability.types?.array as? [ModifiableValue]
            abilityView?.data = ability.data?.array as? [ModifiableValue]
            abilityView?.modifiers = ability.modifiers?.allObjects as? [Modifier]
            abilityView?.cooldown = ability.cooldown
            abilityView?.mana = ability.mana
            abilityView?.notes = ability.notes?.array as? [Note]
            
            abilityView?.layoutIfNeeded()

        }
    }
    
    private var scrollView: UIScrollView!
    private(set) var abilityView: AbilityView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        view.addSubview(scrollView)
    }
    
    
}
