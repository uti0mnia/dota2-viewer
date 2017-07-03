//
//  HeroAttributeCellDelegate.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-05-13.
//  Copyright © 2017 self. All rights 
//

protocol HeroAttributeViewDelegate: class {
    func heroAttributeView(_ heroAttributeView: HeroAttributeView, sliderDidChangeValue newValue: Int)
}
