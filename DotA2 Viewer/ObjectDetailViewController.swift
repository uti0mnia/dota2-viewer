//
//  ObjectDetailsViewController.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-02.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class ObjectDetailViewController: UIViewController, ObjectHeaderViewDelegate {
    
    public var objectHeaderView: ObjectHeaderView? {
        return nil
    }
    
    private var contentView = UIView()
    private var currentChildViewController: UIViewController?
    
    public var headerTopLayout: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.flatBlackColorDark()
        
        guard let objectHeaderView = objectHeaderView else {
            return
        }
        
        view.addSubview(objectHeaderView)
        view.addSubview(contentView)
        
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func addConstraints() {
        objectHeaderView?.snp.makeConstraints() { make in
            // Lower priority in case of dragging size.
            headerTopLayout = make.top.equalTo(topLayoutGuide.snp.bottom).constraint
            make.left.right.equalTo(view)
            make.bottom.equalTo(contentView.snp.top).priority(999)
        }
        
        contentView.snp.makeConstraints() { make in
            make.left.bottom.right.equalTo(view)
        }
    }
    
    // TODO: Animate this stuff.
    final public func swapChildViewController(to viewController: UIViewController) {
        
        currentChildViewController?.willMove(toParentViewController: nil)
        currentChildViewController?.view.removeFromSuperview()
        currentChildViewController?.removeFromParentViewController()
        
        currentChildViewController = viewController
        
        addChildViewController(viewController)
        contentView.addSubview(viewController.view)
        viewController.view.frame = contentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParentViewController: self)
    }
    
    // MARK: - ObjectHeaderViewDelegate
    
    func objectHeaderView(_ objectHeaderView: ObjectHeaderView, didChangeImageHeightTo height: CGFloat) {
        guard let navBarHeight = navigationController?.navigationBar.bounds.height else {
            headerTopLayout?.update(offset: 0)
            return
        }
        
        if objectHeaderView.bounds.height > ObjectHeaderView.maximumHeight {
            headerTopLayout?.update(offset: 0)
            return
        }
        
        let effectiveHeight = objectHeaderView.bounds.height - objectHeaderView.minimumHeight
        let effectiveMaxHeight = ObjectHeaderView.maximumHeight - objectHeaderView.minimumHeight
        
        let newOffset = navBarHeight * (effectiveHeight / effectiveMaxHeight - 1)
        headerTopLayout?.update(offset: newOffset)
    }
    
    
}
