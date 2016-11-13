//
//  AboutViewController.swift
//  Biblio
//
//  Created by Adam on 11/12/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class AboutViewController: UIViewController {

    @IBOutlet weak var introLabel: TTTAttributedLabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delaysContentTouches = false
        let text = introLabel.text! as NSString
        let range = text.range(of: "create a ticket here")
        let url = URL(string: "https://github.com/atecle/biblio/issues")!
        introLabel.addLink(to: url, with: range)
    }

}
