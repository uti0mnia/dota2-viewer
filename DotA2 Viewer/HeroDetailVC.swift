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
    var fullStackView: UIStackView!
    var heroImage: UIImageView!
    var attackTypeLabel: UILabel!
    var roleLabel: UILabel!
    var intelligenceLabel: UILabel!
    var agilityLabel: UILabel!
    var strengthLabel: UILabel!
    var damageLabel: UILabel!
    var speedLabel: UILabel!
    var armorLabel: UILabel!
    var extraSegmentControl: UISegmentedControl!
    
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
        setStackView()
        //scrollView.contentSize = fullStackView.frame.size
        scrollView.alwaysBounceVertical = true
        
        // add the segment control target
        extraSegmentControl.addTarget(self, action: #selector(didChangeSegment(sender:)), for: .valueChanged)
        
        
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
        heroImage.image = hero.objectImage()
        attackTypeLabel.text = hero.attackType
        roleLabel.text = hero.role
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
        intelligenceLabel.text = stat.intelligence
        agilityLabel.text = stat.agility
        strengthLabel.text = stat.strength
        damageLabel.text = stat.damage
        speedLabel.text = stat.speed
        armorLabel.text = stat.armor
    }
    
    fileprivate func setStackView() {
        heroImage = UIImageView()
        attackTypeLabel = UILabel()
        roleLabel = UILabel()
        
        // set the primary stats stack view
        intelligenceLabel = UILabel()
        agilityLabel = UILabel()
        strengthLabel = UILabel()
        damageLabel = UILabel()
        speedLabel = UILabel()
        armorLabel = UILabel()
        let stackView1 = UIStackView(arrangedSubviews: [intelligenceLabel, agilityLabel, strengthLabel])
        let stackView2 = UIStackView(arrangedSubviews: [damageLabel, speedLabel, armorLabel])
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView1.axis = .vertical
        stackView2.axis = .vertical
        stackView1.alignment = .center
        stackView2.alignment = .center
        stackView1.distribution = .fillEqually
        stackView2.distribution = .fillEqually
        let pStackView = UIStackView(arrangedSubviews: [stackView1, stackView2])
        pStackView.axis = .horizontal
        pStackView.alignment = .center
        pStackView.distribution = .fillEqually
        
        // set up the segment controll
        extraSegmentControl = UISegmentedControl(items: ["Bio", "Stats", "Abilities"])
        extraSegmentControl.tintColor = UIColor.red
        extraSegmentControl.selectedSegmentIndex = 0
        
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
        fullStackView = UIStackView()
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        fullStackView.axis = .vertical
        fullStackView.alignment = .fill
        fullStackView.distribution = .fillProportionally
        scrollView.addSubview(fullStackView)
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView(==scrollView)]|",
                                                                    options: .alignAllCenterX,
                                                                    metrics: nil,
                                                                    views: ["stackView": fullStackView, "scrollView": scrollView]))
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["stackView": fullStackView]))
        
        for i in [heroImage, attackTypeLabel, roleLabel, pStackView, extraSegmentControl] {
            fullStackView.addArrangedSubview(i)
        }
        
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
        
        //scrollView.contentSize = fullStackView.frame.size
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







































