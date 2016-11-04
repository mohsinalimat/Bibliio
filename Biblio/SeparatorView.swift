//
//  SeparatorView.swift
//  Biblio
//
//  Created by Adam on 11/4/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

public class SeparatorView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor.softGrey()
        configureHeight()
    }
    
    func configureHeight() {
        translatesAutoresizingMaskIntoConstraints = false
        let heightConstant = 2.0/UIScreen.main.scale
        let height = NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: heightConstant)
        addConstraint(height)
    }
}
