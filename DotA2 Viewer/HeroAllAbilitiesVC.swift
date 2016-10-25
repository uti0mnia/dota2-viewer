//
//  HeroAllAbilitiesVC.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-22.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroAllAbilitiesVC: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    var abilities: [Ability]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setAbilities()
    }
    
    private func createHeroAbilityVC() -> HeroAbilityVC {
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HeroAbilityVC") as! HeroAbilityVC
        return vc
    }
    
    private func add(controller: HeroAbilityVC, withAbility ability: Ability, toView view: UIView) {
        self.addChildViewController(controller)
        view.addSubview(controller.view)
        controller.ability = ability
        controller.view.frame = view.bounds
        controller.didMove(toParentViewController: self)
        
    }
    
    private func setAbilities() {
        guard abilities != nil else { return }
        
        for ability in abilities {
            // create view and add it to the stack
            let view = UIView()
            stackView.addArrangedSubview(view)
            
            // add the controller
            let vc = createHeroAbilityVC()
            add(controller: vc, withAbility: ability, toView: view)
        }
        
    }

}




































