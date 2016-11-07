//
//  HeroBioVC.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-22.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class HeroBioVC: DAUIViewController {
    
    
    @IBOutlet weak var text: UITextView!
    var bio: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard bio != nil else { return }
        text.text = bio!.replacingOccurrences(of: "\\n", with: "\n").replacingOccurrences(of: "--", with: " ")
        text.sizeToFit()
    }

}
