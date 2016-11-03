//
//  BaseInputViewController.swift
//  Biblio
//
//  Created by Adam on 11/3/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

public class BaseInputViewController: UIViewController {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
