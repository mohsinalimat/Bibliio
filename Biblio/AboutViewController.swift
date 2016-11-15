//
//  AboutViewController.swift
//  Bibliio
//
//  Created by Adam on 11/12/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class AboutViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var introLabel: TTTAttributedLabel!
    @IBOutlet weak var libraryListLabel: TTTAttributedLabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delaysContentTouches = false
        configureIntroLabel()
        configureLibraryListLabel()
    }

    private func configureIntroLabel() {
        introLabel.delegate = self
        let text = introLabel.text! as NSString
        let range = text.range(of: "create a ticket here")
        let url = URL(string: "https://github.com/atecle/bibliio/issues")!
        introLabel.addLink(to: url, with: range)
    }
    
    private func configureLibraryListLabel() {
        libraryListLabel.delegate = self
        let text = libraryListLabel.text! as NSString
        let range = text.range(of: "Icons8")
        let url = URL(string: "https://icons8.com")
        libraryListLabel.addLink(to: url, with: range)
    }
    
    func open(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}

extension AboutViewController: TTTAttributedLabelDelegate {
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        open(url: url)
    }
    
}
