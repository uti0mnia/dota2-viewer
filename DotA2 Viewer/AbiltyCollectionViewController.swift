//
//  AbiltyCollectionViewController.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-23.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import CenteredCollectionView

class AbilityCollectionViewController: UIViewController, UICollectionViewDataSource {
    
    private static let abilityReusableCell = "abilityCell"
    
    public var abilities: [Ability]? {
        didSet {
            collectionView.reloadData()
            
            collectionView.scrollTo(index: 0, animated: false)
        }
    }
    
    private var collectionView = CenteredCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        collectionView.frame = view.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.register(AbilityCollectionCell.self, forCellWithReuseIdentifier: AbilityCollectionViewController.abilityReusableCell)
        
        collectionView.itemSize = collectionView.bounds.size
        collectionView.minimumLineSpacing = 0
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
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
        cell.ability = abilities?[indexPath.row]
        return cell
    }
}
