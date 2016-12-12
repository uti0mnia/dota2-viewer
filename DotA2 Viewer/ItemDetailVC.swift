//
//  ItemDetailVC.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-12-10.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class ItemDetailVC: UIViewController {
    // MARK - Properties
    var item: Item!
    fileprivate var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    fileprivate var itemSV: ItemStackView = {
        let sv = ItemStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    fileprivate lazy var titleLabel: DAMainLabel = {[unowned self] in
        let lbl = DAMainLabel(style: .large)
        lbl.text = self.item.name!
        lbl.sizeToFit()
        return lbl
    }()
    fileprivate var model: ItemDetailModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard item != nil else { return }
        configure()
    }
    
    private func configure() {
        model = ItemDetailModel(item: item)
        configureViews()
        setup()
    }
    
    /* configures the views to the view controller */
    fileprivate func configureViews() {
        // scrollview
        self.view.addSubview(scrollView)
        var constraints = [NSLayoutConstraint]()
        constraints += createConstraints(withVisual: "H:|[scrollView]|", withViews: ["scrollView": scrollView], options: .alignAllCenterX)
        constraints += createConstraints(withVisual: "V:|[scrollView]|", withViews: ["scrollView": scrollView], options: .alignAllCenterX)
        self.view.addConstraints(constraints)
        
        // item stack view
        scrollView.addSubview(itemSV)
        constraints.removeAll()
        constraints += createConstraints(withVisual: "H:|[stackView(==scrollView)]|", withViews: ["stackView": itemSV, "scrollView": scrollView], options: .alignAllCenterX)
        constraints += createConstraints(withVisual: "V:|[stackView]|", withViews: ["stackView": itemSV], options: .alignAllCenterX)
        scrollView.addConstraints(constraints)
        
        // configure the expandable stack views
    }

    /* does the setup from the model to the vies */
    fileprivate func setup() {
        self.navigationItem.titleView = titleLabel
        itemSV.additionalInfoSV.textLabel.text = model.additionalInfoPretty
        itemSV.detailsSV.textLabel.attributedText = model.detailsString
        itemSV.loreSV.textLabel.text = model.lore
        itemSV.mainView.availabilityLabel.text = model.availability.joined(separator: ", ")
        itemSV.mainView.costLabel.text = model.cost
        itemSV.mainView.itemImageView.image = model.image
        itemSV.mainView.typeImageView.image = model.typeImg
        itemSV.mainView.typeLabel.text = model.type
    }
    
    fileprivate func createConstraints(withVisual str: String, withViews views: [String: Any], options: NSLayoutFormatOptions = []) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: str, options: options, metrics: nil, views: views)
    }

}











































