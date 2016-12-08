//
//  InsetTextField.swift
//  Bibliio
//
//  Created by Adam on 12/8/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

open class InsetTextField: TextField {

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let insets = UIEdgeInsetsMake(0, 0, 0, 40)
        return UIEdgeInsetsInsetRect(bounds, insets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let insets = UIEdgeInsetsMake(0, 0, 0, 40)
        return UIEdgeInsetsInsetRect(bounds, insets)
    }

}
