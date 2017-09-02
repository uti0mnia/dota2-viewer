//
//  AbiltyCollectionViewController.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-23.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import CenteredCollectionView
import CHIPageControl

class AbilityCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, AbilityCollectionCellDelgate {
    
    private static let abilityReusableCell = "abilityCell"
    private static let pageControlHeight: CGFloat = 20
    
    public var abilities: [Ability]? {
        didSet {
            guard let abilities = abilities else {
                return
            }
            
            collectionView.reloadData()
            collectionView.scrollTo(index: 0, animated: false)
            
            pageControl.numberOfPages = abilities.count
            pageControl.set(progress: 0, animated: false)
        }
    }
    
    private var collectionView = CenteredCollectionView()
    private var pageControl = CHIPageControlAji()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(pageControl)
        let controlHeight = AbilityCollectionViewController.pageControlHeight
        pageControl.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: controlHeight)
        pageControl.autoresizingMask = [.flexibleWidth]
        
        pageControl.radius = Layout.pageControlRadius
        pageControl.inactiveTransparency = -1
        pageControl.borderWidth = Layout.pageControlBorderWidth
        pageControl.tintColor = Colours.secondaryColour
        
        view.addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: controlHeight, width: view.bounds.width, height: view.bounds.height - controlHeight)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(AbilityCollectionCell.self, forCellWithReuseIdentifier: AbilityCollectionViewController.abilityReusableCell)
        collectionView.itemSize = collectionView.bounds.size
        collectionView.minimumLineSpacing = 0
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    // Handle collectionView size change for it's imageSize.
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.itemSize = collectionView.bounds.size
    }
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return abilities?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AbilityCollectionViewController.abilityReusableCell, for: indexPath) as! AbilityCollectionCell
        cell.delegate = self
        cell.ability = abilities?[indexPath.row]
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = self.collectionView.frame.size.width
        let progress = Double(self.collectionView.contentOffset.x / pageWidth)
        pageControl.progress = progress
    }
    
    // MARK: - AbilityCollectionCellDelgate
    
    func abilityCollectionCell(_ abilityCollectionCell: AbilityCollectionCell, didTapOnSpecial special: String) {
        if let message = Ability.specialDescriptions[special] {
            ToastManager.shared.displayToastMessage(message)
        }
    }
}
