//
//  RecipeStackView.swift
//  DotA2 Assistant
//
//  Created by McLewin, Casey on 2016-12-13.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

final class RecipeSubStackView: UIStackView {
    // MARK - Properties
    /* Private */
    fileprivate var image: UIImage
    fileprivate var buildsFrom: [UIImage]?
    fileprivate var buildsInto: [UIImage]?
    fileprivate var needsRecipe: Bool
    fileprivate var midSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .equalSpacing
        return sv
    }()
    var topSV: UIStackView?
    var bottomSV: UIStackView?
    fileprivate let upArrow = UIImage(named: "uparrow.png")
    fileprivate let kArrowHeight: CGFloat = 20
    fileprivate let kImageHeight: CGFloat = 70
    
    
    // MARK - Initializers
    init(frame: CGRect = CGRect(), image: UIImage, buildsFrom: [UIImage]?, buildsInto: [UIImage]?, needsRecipe: Bool) {
        self.image = image
        self.buildsFrom = buildsFrom
        self.buildsInto = buildsInto
        self.needsRecipe = needsRecipe
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Methods
    /* Sets up the stack view and its subviews */
    fileprivate func setup() {
        // the the properties
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillProportionally
        self.spacing = 8
        
        // configure the stack views
        configureTopSV()
        configureMidSV()
        configureBottomSV()
    }
    
    /* configures the top SV with what the item builds into */
    fileprivate func configureTopSV() {
        // make sure item builds into something
        guard let images = buildsInto else {
            return
        }
        
        // init the topSV
        topSV = buildStackView()
        
        // add images to topSV
        for img in images {
            let btn = buildRecipeButton(withImage: img, limitHeightTo: 70)
            topSV?.addArrangedSubview(btn)
        }
        
        // add topSV to self
        self.addArrangedSubview(topSV!)
    }
    
    /* configures the middle SV with the current item image and arrows for what it builds and what it is built from */
    fileprivate func configureMidSV() {
        // add the top arrow if necessary
        if buildsInto != nil {
            let imgView = buildImageView(withImage: upArrow, limitHeightTo: kArrowHeight)
            midSV.addArrangedSubview(imgView)
        }
        // add the item image
        let imgView = buildImageView(withImage: image, limitHeightTo: kImageHeight)
        midSV.addArrangedSubview(imgView)
        
        // add up arrow for builds from if necessary
        if buildsFrom != nil {
            let imgView = buildImageView(withImage: upArrow, limitHeightTo: kArrowHeight)
            midSV.addArrangedSubview(imgView)
        }
        
        // add it to self
        self.addArrangedSubview(midSV)
    }
    
    /* configures the bottom SV with the images that build into the item */
    fileprivate func configureBottomSV() {
        // make sure item builds from something
        guard let images = buildsFrom else {
            return
        }
        
        // init the bottomSV
        bottomSV = buildStackView()
        
        // add buttons to sv
        for img in images {
            let btn = buildRecipeButton(withImage: img, limitHeightTo: kImageHeight)
            bottomSV?.addArrangedSubview(btn)
        }
        
        // add recipe if necessary
        if needsRecipe {
            let image = UIImage(named: "recipe.png")
            let imgView = buildImageView(withImage: image, limitHeightTo: kImageHeight)
            bottomSV?.addArrangedSubview(imgView)
        }
        
        // add self to the view
        self.addArrangedSubview(bottomSV!)
    }
    
    fileprivate func buildStackView() -> UIStackView {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }
    
    fileprivate func buildImageView(withImage image: UIImage?, limitHeightTo height: CGFloat) -> UIImageView {
        // create image view
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = image
        
        // constraints
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[iv(height)]", options: [], metrics: ["height": height], views: ["iv": iv])
        constraints.forEach({ $0.priority = 999 })
        iv.addConstraints(constraints)
        
        // return image view
        return iv
    }
    
    fileprivate func buildRecipeButton(withImage image: UIImage, limitHeightTo height: CGFloat) -> RecipeButton {
        let btn = RecipeButton(type: .custom)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(image, for: .normal)
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[btn(height)]", options: [], metrics: ["height": height], views: ["btn": btn])
        constraints.forEach({ $0.priority = 999 })
        btn.addConstraints(constraints)
        return btn
    }

}





































