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

    // extra views
    lazy var abilitiesStackView: AbilitiesStackView = { [unowned self] in
        let sv = AbilitiesStackView()
        guard self.object is Hero else { return sv }
        let hero = self.object as! Hero
        sv.abilities = hero.ability?.array as! [Ability]
        sv.setStack()
        return sv
    }()
    
    lazy var bioStackView: HeroBioStackView = {[unowned self] in
        let sv = HeroBioStackView()
        guard self.object is Hero else { return sv }
        let hero = self.object as! Hero
        sv.bio = hero.bio?.replacingOccurrences(of: "--", with: " ").replacingOccurrences(of: "\\n", with: "\n") // fix this shit
        sv.setStack()
        return sv
    }()
    
    lazy var statsStackView: StatsStackView = {[unowned self] in
        let sv = StatsStackView()
        guard self.object is Hero else { return sv }
        let hero = self.object as! Hero
        sv.stats = hero.stat?.array as! [Stat]
        sv.setStack()
        return sv
    }()
    
    // vars to keep track of things
    var currentExtraSV: UIStackView!
    
    /* Methods */
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            swapDetailContainer(from: currentExtraSV, to: statsStackView)
            break
        case 2:
            swapDetailContainer(from: currentExtraSV, to: abilitiesStackView)
        default:
            break
        }
    }
    
    // sets the view of self
    fileprivate func setView() {
        guard object is Hero else { return }
        
        let hero = object as! Hero
        
        // set self's displays
        self.title = hero.name
        fullStackView.heroImage.image = hero.objectImage()
        fullStackView.attackTypeLabel.text = hero.attackType
        fullStackView.roleLabel.text = hero.role
        setPrimaryStats()
        
        
        // add default child
        currentExtraSV = bioStackView
        fullStackView.addArrangedSubview(bioStackView)
        
    }
    
    
    // adds the primary stat view controller as a child and to the container view
    fileprivate func setPrimaryStats() {
        guard object is Hero else { return }
        let hero = object as! Hero
        
        guard hero.primaryStat != nil else { return }
        let stat = hero.primaryStat!
        // set values
        fullStackView.intelligenceLabel.text = stat.intelligence
        fullStackView.agilityLabel.text = stat.agility
        fullStackView.strengthLabel.text = stat.strength
        fullStackView.damageLabel.text = stat.damage
        fullStackView.speedLabel.text = stat.speed
        fullStackView.armorLabel.text = stat.armor
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
        fullStackView = HeroDetailStackView()
        fullStackView.setStack()
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
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







































