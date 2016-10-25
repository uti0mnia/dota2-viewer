//
//  HeroDetailVC.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController {
    // outlets
    @IBOutlet weak var containerView: UIView!
    
    // variables for keep track of stuff
    var object: ListObject!
    var currentChild: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the container view
        containerView.frame = self.view.bounds
        
        guard object != nil else { return }
        configureView()
    }
    
    private func configureView() {
        switch object {
        case is Item:
            displayContentController(newItemDetailVC())
        case is Hero:
            displayContentController(newHeroDetailVC())
        default:
            break
        }
        
    }
    
    fileprivate func newItemDetailVC() -> ItemDetailVC {
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailVC
        vc.del = self
        return vc
    }
    
    fileprivate func newHeroDetailVC() -> HeroDetailVC {
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HeroDetailVC") as! HeroDetailVC
        return vc
    }
    
    fileprivate func displayContentController(_ controller: ObjectDetailVC) {
        self.title = object.name // set the nav bar title
        self.addChildViewController(controller) // add child VC
        controller.object = object // set the controller's object
        self.containerView.addSubview(controller.view) // add child view
        controller.view.frame = self.containerView.bounds // configure frame
        controller.didMove(toParentViewController: self) // notify vc
        
        self.currentChild = controller // set the reference
       
        
    }
    
    fileprivate func cycleFrom(viewController oldVC: UIViewController, toViewController newVC: ObjectDetailVC) {
        // remove the oldVC's view and itself
        oldVC.view.removeFromSuperview()
        oldVC.removeFromParentViewController()
        
        // display the newVC - made for animations
        displayContentController(newVC)
    }
    
}

extension DetailVC: DetailVCDelegate {
    func didSelectObject(object: ListObject) {
        // set the object
        self.object = object
        
        // swap out the correct view controller
        switch object {
        case is Item:
            cycleFrom(viewController: currentChild, toViewController: newItemDetailVC())
        case is Hero:
            cycleFrom(viewController: currentChild, toViewController: newHeroDetailVC())
        default:
            break
        }
    }
}
































