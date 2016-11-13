//
//  File.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2016-11-07.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

let kTableViewCellImageSpaceR: CGFloat = 10
let kTableViewCellImageSpaceL: CGFloat = 8
let kDotaFontLarge = UIFont(name: "TrajanPro-Regular", size: 16)!
let kDotaFontSmall = UIFont(name: "TrajanPro-Regular", size: 10)!
let kRadiance = UIFont(name: "Radiance", size: 18)!

// stats
var kHPGain: NSNumber { get { return 20 } }
var kHPRegenGain: NSNumber { get { return 0.03 } }
var kManaGain: NSNumber { get { return 12 } }
var kManaRegenGain: NSNumber { get { return 0.04 } }
var kSpellDamageGain: NSNumber { get { return 0.0625 } }
var kArmourGain: NSNumber { get { return NSNumber(floatLiteral: 1/7) } }
