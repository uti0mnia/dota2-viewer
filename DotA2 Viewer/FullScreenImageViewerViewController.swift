//
//  DAFullScreenImageViewer.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-08-31.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class FullScreenImageViewerViewController: UIViewController {
    
    private(set) var imageView = UIImageView()
    
    private var swipeGesture: UITapGestureRecognizer?
    
    public weak var delegate: FullScreenImageViewerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        
        swipeGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(swipeGesture!)
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.black
        imageView.frame = view.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(imageView)
        
    }
    
    
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        self.delegate?.fullScreenImageViewerViewControllerDidDismissImageView(self)
    }
}
