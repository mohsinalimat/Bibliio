//
//  UIFontExtensions.swift
//  Biblio
//
//  Created by Adam on 11/1/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

extension UIFont {
    static func titleLabelFont() -> UIFont {
        if DeviceType.IS_IPHONE_5 {
            return UIFont.systemFont(ofSize: 14)
        }
        return UIFont.systemFont(ofSize: 16)
    }
    
    static func valueLabelFont() -> UIFont {
        if DeviceType.IS_IPHONE_5 {
            return UIFont.systemFont(ofSize: 14)
        }
        return UIFont.systemFont(ofSize: 15)
    }
}
