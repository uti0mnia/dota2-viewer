//
//  ItemBasicVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-25.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import SnapKit

class ItemBasicViewController: UIViewController, RecipeBuildViewDelegate {
    
    public weak var delegate: ItemBasicViewControllerDelegate?
    
    private var basicView = ItemBasicView()
    
    private var scrollView = UIScrollView()
    
    public var item: Item? {
        didSet {
            basicView.item = item
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        basicView.setDelegateForRecipeView(self)
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalTo(view).priority(999)
        }
        
        scrollView.addSubview(basicView)
        basicView.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
    }
    
    // MARK: - RecipeBuildViewDelegate
    
    func recipeBuildView(_ recipeBuildView: RecipeBuildView, didSelectItemWithName name: String?) {
        assert(name != nil, "RecipePart misconfigured: itemName is nil")
        
        guard let name = name else {
            return
        }
        
        if let item = CoreDataManager.shared.fetchItem(withName: name) {
            print("Did tap on item: \(item.name)")
            
            delegate?.itemBasicViewController(self, didSelectItem: item)
        }
    }
}
