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

class ObjectDetailViewController: UIViewController, FullScreenImageViewerViewControllerDelegate {
    
    public var object: Object?
    
    private var contentView = UIView()
    private var currentChildViewController: UIViewController?
    
    private var fullScreenImageViewController = FullScreenImageViewerViewController()
    
    public var segmentControl: BetterSegmentedControl {
        return BetterSegmentedControl()
    }
    
    public let titleLabel = DALabel(style: .title)
    
    private let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colours.primaryColour
        
        fullScreenImageViewController.delegate = self
        fullScreenImageViewController.modalTransitionStyle = .crossDissolve
        
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
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.insertSubview(imageView, at: 0)
        
        addConstraints()
    }
    
    private func addConstraints() {
        
        imageView.snp.makeConstraints() { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(Layout.navigationControllerHeight)
        }
        
        segmentControl.snp.makeConstraints() { make in
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(Layout.defaultPadding)
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
        
        imageView.image = UIImage(named: object?.imageName ?? "")
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
    
    @objc private func controlValueDidChange(_ control: BetterSegmentedControl) {
        if let vc = viewControllerForControlIndex(control.index) {
            swapChildViewController(to: vc)
        }
    }
    
    public func viewControllerForControlIndex(_ index: UInt) -> UIViewController? {
        // For subclasses.
        return nil
    }
    
    public func displayFullScreenObjectImage() {
        guard let image = imageView.image else {
            return
        }
        
        fullScreenImageViewController.imageView.image = image
        present(fullScreenImageViewController, animated: true, completion: nil)
    }
    
    // MARK: - FullScreenImageViewerViewControllerDelegate
    func fullScreenImageViewerViewControllerDidDismissImageView(_ fullScreenImageViewerViewController: FullScreenImageViewerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
