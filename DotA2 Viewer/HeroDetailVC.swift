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
    
    // making the VCs
    lazy var bioVC: HeroBioVC = {
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HeroBioVC") as! HeroBioVC
        return vc
    }()
    
    lazy var statsVC: HeroStatsVC = {
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HeroStatsVC") as! HeroStatsVC
        return vc
    }()
    
    lazy var abilitiesVC: HeroAllAbilitiesVC = {
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HeroAllAbilitiesVC") as! HeroAllAbilitiesVC
        return vc
    }()
    
    // vars to keep track of things
    var currentExtraVC: UIViewController!
    
    /* Methods */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // inits the views programatically
        initViews()
        
        //scrollView.contentSize = fullStackView.frame.size
        scrollView.alwaysBounceVertical = true
        
        // add the segment control target
        fullStackView.extraSegmentControl.addTarget(self, action: #selector(didChangeSegment(sender:)), for: .valueChanged)
        
        
        // set the view up
        setView()
    }
    
    // handling the extra view at the bottom for Bio/Stats/Abilities
    @objc fileprivate func didChangeSegment(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            swapDetailContainer(from: currentExtraVC, to: bioVC)
        case 1:
            swapDetailContainer(from: currentExtraVC, to: statsVC)
        case 2:
            swapDetailContainer(from: currentExtraVC, to: abilitiesVC)
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
        
        // set child VC's data
        bioVC.bio = hero.bio
        statsVC.stats = hero.stat?.array as! [Stat]
        abilitiesVC.abilities = hero.ability?.allObjects as! [Ability]
        
        // add default child
        displayExtraContentController(bioVC)
        
        
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
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["stackView": fullStackView]))
        
        
    }

}


/* UIViewController Child Handling */
extension HeroDetailVC {
    
    // displays the given UIViewController's view into the Extra view at the bottin (Bio, Stat or Abilities)
    fileprivate func displayExtraContentController(_ controller: UIViewController) {
        let myView = UIView()
        myView.heightAnchor.constraint(equalToConstant: controller.view.frame.height).isActive = true
        fullStackView.addArrangedSubview(myView)
        self.addChildViewController(controller)
        myView.addSubview(controller.view)
        controller.view.frame = myView.bounds
        controller.didMove(toParentViewController: self)
        currentExtraVC = controller
        
    }
    
    
    // meant to handle the swapping of the extra VC at the bottom
    fileprivate func swapDetailContainer(from vc1: UIViewController, to vc2: UIViewController) {
        // remove old vc's view and itself
        fullStackView.removeArrangedSubview(fullStackView.arrangedSubviews.last!)
        vc1.view.removeFromSuperview()
        vc1.removeFromParentViewController()
        
        //display the new vc
        displayExtraContentController(vc2)
        
    }
}







































