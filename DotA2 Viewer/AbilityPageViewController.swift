//
//  AbilityViewController.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-22.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class AbilityPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    public var abilities: [Ability]? {
        didSet {
            guard let abilities = abilities else {
                setViewControllers(nil, direction: .forward, animated: false, completion: nil)
                return
            }
            
            if abilities.count == 0 {
                setViewControllers(nil, direction: .forward, animated: false, completion: nil)
                return
            }
            
            if abilities.count > abilityViewControllers.count {
                let extra = abilities.count - abilityViewControllers.count
                for _ in 0..<extra {
                    abilityViewControllers.append(AbilityViewController())
                }
            }
            
            if abilities.count < abilityViewControllers.count {
                let extra = abilityViewControllers.count - abilities.count
                for _ in 0..<extra {
                    abilityViewControllers.removeLast()
                }
            }
            
            for index in 0..<abilities.count {
                abilityViewControllers[index].ability = abilities[index]
            }
            
            abilityViewControllers[0].ability = abilities.first
            setViewControllers([abilityViewControllers[0]], direction: .forward, animated: false, completion: nil)
        }
    }
    
    private var abilityViewControllers = [AbilityViewController]()
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = abilityViewControllers.index(of: viewController as! AbilityViewController) else {
            return nil
        }
        
        if index == abilityViewControllers.count - 1 {
            return nil
        }
        
        return abilityViewControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = abilityViewControllers.index(of: viewController as! AbilityViewController) else {
            return nil
        }
        
        if index == 0 {
            return nil
        }
        
        return abilityViewControllers[index - 1]
    }
}
