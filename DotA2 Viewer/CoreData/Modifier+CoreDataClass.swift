//
//  Modifer+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import UIKit
import CoreData


public class Modifier: ArrayItem {
    
    public var getUIColour: UIColor {
        switch self.colour {
        case 0:
            return Colours.modifierGreen
        case 1:
            return Colours.modifierRed
        default:
            return Colours.defaultTextColour
        }
    }
}
