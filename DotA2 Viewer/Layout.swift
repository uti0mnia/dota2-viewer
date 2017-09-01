//
//  Layout.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-06-10.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class Layout {
    public static var abilityImageSize: CGSize = CGSize(width: 128, height: 128)
    
    public static var heroImageSize: CGSize = CGSize(width: 256, height: 144)
    
    public static var statusBarHeight: CGFloat = 20
    
    public static var objectImageMinimumHeight: CGFloat = 64
    
    public static var textAttachmentBounds: CGRect = CGRect(x: 0, y: Layout.attachmentDescender, width: 20, height: 20)
    
    public static var attachmentDescender: CGFloat = -6
    
    public static var textLabelPreferredHeight: CGFloat = Layout.textAttachmentBounds.height + 2 * 5
    
    public static let defaultPadding: CGFloat = 8
    
    public static let toastCornerRadius: CGFloat = 2
    
    public static let toastMargin = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
    
    public static let toastMessageHeight: CGFloat = 60
    
    public static let pageControlRadius: CGFloat = 5
    
    public static let pageControlBorderWidth: CGFloat = 1
    
    public static let roundedRectangleRadius: CGFloat = 6
    
    public static let segmentControlHeight: CGFloat = 44
    
    public static let segmentControlCornerRadius: CGFloat = 5
    
    public static let segmentControlIndicatorRadius: CGFloat = 5
    
    public static let primaryAttributeBorderWidth: CGFloat = 2
    
    public static let navigationControllerHeight: CGFloat = 64
}
