//
//  HeroDetailVC.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-22.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

private enum SelectedView {
    case bio, stats, ability
}

class HeroDetailVC: ObjectDetailVC {

    /* Outlets */
    var scrollView: UIScrollView!
    var fullStackView: HeroDetailStackView!
    
    /* variables */
    // this if hero is nil, then nothing in the view controller will be accessing it because it will be blocked off in viewDidLoad
    private var hero: Hero? {
        get {
            return object as? Hero
        }
    }

    // extra views
    lazy var abilitiesStackView: AbilitiesStackView = { [unowned self] in
        let sv = AbilitiesStackView()
        sv.abilities = self.hero?.ability?.array as! [Ability]
        sv.setStack()
        return sv
    }()
    
    lazy var bioStackView: HeroBioStackView = {[unowned self] in
        let sv = HeroBioStackView()
        sv.bio = self.hero?.bio?.replacingOccurrences(of: "--", with: " ").replacingOccurrences(of: "\\n", with: "\n") // fix this shit
        sv.setStack()
        return sv
    }()
    
    // vars to keep track of things
    var currentExtraSV: UIStackView!
    
    /* Methods */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make sure hero isn't nil
        guard hero != nil else {
            return
        }
        
        // inits the views programatically
        initViews()
        
        // add the segment control target
        fullStackView.extraSegmentControl.addTarget(self, action: #selector(didChangeSegment(sender:)), for: .valueChanged)
        
        
        // set the view up
        setView()
    }
    
    // handling the extra view at the bottom for Bio/Stats/Abilities
    @objc fileprivate func didChangeSegment(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            swapDetailContainer(from: currentExtraSV, to: bioStackView)
        case 1:
            swapDetailContainer(from: currentExtraSV, to: abilitiesStackView)
        default:
            break
        }
    }
    
    // sets the view of self
    fileprivate func setView() {
        // set self's displays
        fullStackView.heroImage.image = hero?.objectImage()
        fullStackView.attackTypeLabel.text = hero?.attackType
        fullStackView.roleLabel.text = hero?.role
        
        
        // add default child
        currentExtraSV = bioStackView
        fullStackView.addArrangedSubview(bioStackView)
        
    }

    fileprivate func initViews() {
        
        // set up scroll view
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        self.view.addSubview(scrollView)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|",
                                                                options: [],
                                                                metrics: nil,
                                                                views: ["scrollView": scrollView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|",
                                                                options: [],
                                                                metrics: nil,
                                                                views: ["scrollView": scrollView]))
        
        
        // set up the full view
        let attributeSet = AttributeSet(hero: hero!)
        fullStackView = HeroDetailStackView(attributeSet: attributeSet, stats: hero!.stats)
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        fullStackView.layoutMargins = UIEdgeInsetsMake(0, 8, 0, 8)
        fullStackView.isLayoutMarginsRelativeArrangement = true
        scrollView.addSubview(fullStackView)
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView(==scrollView)]|",
                                                                    options: .alignAllCenterX,
                                                                    metrics: nil,
                                                                    views: ["stackView": fullStackView, "scrollView": scrollView]))
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[stackView]-|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["stackView": fullStackView]))
        
        
    }
    
    func open(url: URL) {
        
    }

}


/* UIViewController Child Handling */
extension HeroDetailVC {
    // meant to handle the swapping of the extra VC at the bottom
    fileprivate func swapDetailContainer(from sv1: UIStackView, to sv2: UIStackView) {
        // do async because if abilities is a big view there's a small delay in showing it - should make better for older devices as well
        DispatchQueue.main.async {
            //block the segment view in case
            self.fullStackView.extraSegmentControl.isEnabled = false
            
            // do work
            sv1.removeFromSuperview()
            self.fullStackView.addArrangedSubview(sv2)
            self.currentExtraSV = sv2
            
            // unblock it
            self.fullStackView.extraSegmentControl.isEnabled = true
        }
    }
}







































