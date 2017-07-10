//
//  HeroTalentsView.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-07-04.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class HeroTalentsView: UIStackView {
    
    private var talentViews = [HeroTalentView]()
    private var notesLabel = DALabel()
    
    public var talents: [Talent]? {
        didSet {
            guard let talents = talents else {
                return
            }
            
            assert(talents.count == talentViews.count, "Misconfigured HeroTalentsView")
            
            for index in 0..<talents.count {
                talentViews[index].talent = talents[index]
            }
        }
    }
    public var notes: [Note]? {
        didSet {
            notesLabel.removeFromSuperview()
            
            guard let notes = notes else {
                return
            }
            
            notesLabel.attributedText = Note.prettify(notes)
            
            addArrangedSubview(notesLabel)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        axis = .vertical
        distribution = .fillProportionally
        spacing = 8
        
        let topStack = UIStackView()
        topStack.axis = .vertical
        topStack.distribution = .fillEqually
        addArrangedSubview(topStack)
        
        for _ in 0..<4 {
            let talentView = HeroTalentView()
            talentViews.append(talentView)
            topStack.addArrangedSubview(talentView)
        }
        
        notesLabel.numberOfLines = 0
        notesLabel.textColor = Colours.secondaryColour
        notesLabel.font = Fonts.text
        addArrangedSubview(notesLabel)
    }
}
