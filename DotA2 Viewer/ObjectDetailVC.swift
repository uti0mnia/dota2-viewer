//
//  ObjectDetailVC.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-22.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

protocol DetailVCDelegate {
    func didSelectObject(object: ListObject)
}


class ObjectDetailVC: DAUIViewController {

    var object: ListObject!
    var del: DetailVCDelegate?
    
}
