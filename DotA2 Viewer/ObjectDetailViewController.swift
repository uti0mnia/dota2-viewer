//
//  ObjectDetailsViewController.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-02.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit
import BetterSegmentedControl

class ObjectDetailViewController: UIViewController, ObjectHeaderViewDelegate {
    
    public var objectHeaderView: ObjectHeaderView? {
        return nil
    }
    
    private var contentView = UIView()
    private var currentChildViewController: UIViewController?
    
    public var segmentControl: BetterSegmentedControl {
        return BetterSegmentedControl()
    }
    
    public var headerTopLayout: Constraint?
    
    public let titleLabel = DALabel(style: .title)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colours.primaryColour
        
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        
        view.addSubview(contentView)
        
        segmentControl.addTarget(self, action: #selector(controlValueDidChange(_:)), for: .valueChanged)
        segmentControl.titleFont = Fonts.subtitle
        segmentControl.titleColor = Colours.secondaryColour
        
        segmentControl.selectedTitleColor = Colours.secondaryColour
        segmentControl.selectedTitleFont = Fonts.subtitle.bold
        
        segmentControl.cornerRadius = Layout.segmentControlCornerRadius
        segmentControl.indicatorViewBackgroundColor = Colours.segmentedControlBackground
        view.addSubview(segmentControl)
        
        automaticallyAdjustsScrollViewInsets = false
        
        addConstraints()
    }
    
    private func addConstraints() {
        
        segmentControl.snp.makeConstraints() { make in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalTo(view).inset(Layout.defaultPadding)
            make.height.equalTo(Layout.segmentControlHeight)
            make.bottom.equalTo(contentView.snp.top)
        }
        
        contentView.snp.makeConstraints() { make in
            make.left.bottom.right.equalTo(view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            try segmentControl.setIndex(0, animated: false)
        } catch {
            print("Error setting segmentControl to 0 wtf: \(error.localizedDescription)")
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
    
    @objc private func controlValueDidChange(_ control: BetterSegmentedControl) {
        if let vc = viewControllerForControlIndex(control.index) {
            swapChildViewController(to: vc)
        }
    }
    
    public func viewControllerForControlIndex(_ index: UInt) -> UIViewController? {
        // For subclasses.
        return nil
    }
    
}
