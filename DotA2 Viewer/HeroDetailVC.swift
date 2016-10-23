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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var attackTypeLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var agilityLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var armorLabel: UILabel!
    @IBOutlet weak var extraSegmentControl: UISegmentedControl!
    @IBOutlet weak var extraContainerView: UIView!
    
//    // making the VCs
//    lazy var primaryStatVC: PrimaryStatVC = {
//        let sb = UIStoryboard(name: "Detail", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "PrimaryStatVC") as! PrimaryStatVC
//        return vc
//    }()
//    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add the segment control
        extraSegmentControl.addTarget(self, action: #selector(didChangeSegment(sender:)), for: .valueChanged)
        
        scrollView.alwaysBounceVertical = true
        
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
        statsVC.stats = hero.stat?.allObjects as! [Stat]
        abilitiesVC.abilities = hero.ability?.allObjects as! [Ability]
        
        // add default child
        currentExtraVC = bioVC
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
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        self.extraContainerView.sizeThatFits(container.preferredContentSize)
    }

}


/* UIViewController Child Handling */
extension HeroDetailVC {
    // displays the given UIViewController's view into the Extra view at the bottin (Bio, Stat or Abilities)
    fileprivate func displayExtraContentController(_ controller: UIViewController) {
        self.addChildViewController(controller)
        self.extraContainerView.addSubview(controller.view)
        //controller.view.frame = self.extraContainerView.bounds
        controller.didMove(toParentViewController: self)
        
        self.currentExtraVC = controller
    }
    
    
    // meant to handle the swapping of the extra VC at the bottom
    fileprivate func swapDetailContainer(from vc1: UIViewController, to vc2: UIViewController) {
        // remove old vc's view and itself
        vc1.view.removeFromSuperview()
        vc1.removeFromParentViewController()
        
        //display the new vc
        displayExtraContentController(vc2)
        
    }
}







































