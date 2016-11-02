//
//  UIColorExtensions.swift
//  Biblio
//
//  Created by Adam on 11/1/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

extension UIColor {
    static func softRed() -> UIColor {
        return UIColor.init(red: 225/255.0, green: 76/255.0, blue: 47/255.0, alpha: 1)
    }
    
    static func separator() -> UIColor {
        return UIColor.init(red: 236/255.0, green: 236/255.0, blue: 236/255.0, alpha: 1)
    }
    
    static func offWhite() -> UIColor {
        return UIColor.init(red: 248/255.0, green: 243/255.0, blue: 240/255.0, alpha: 1)
    }
    
    static func shadowColor() -> UIColor {
        return UIColor.init(red:225.0/255.0, green:228.0/255.0, blue:228.0/255.0, alpha:1.0)
    }
    
    static func softGrey() -> UIColor {
        return UIColor.init(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1)
    }
}
