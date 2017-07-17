//
//  HeroTalentViewController.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-12.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class HeroTalentViewController: UIViewController {
    
    private var scrollView = UIScrollView()
    private var heroTalentsView = HeroTalentsView()
    
    public var hero: Hero? {
        didSet {
            heroTalentsView.talents = hero?.talents.array as? [Talent]
            heroTalentsView.notes = hero?.talentNotes?.array as? [Note]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalTo(view).inset(Layout.defaultPadding)
        }
        
        scrollView.addSubview(heroTalentsView)
        heroTalentsView.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
    }
}
