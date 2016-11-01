//
//  Book.swift
//  Biblio
//
//  Created by Adam on 10/25/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RealmSwift

class Book: Object {
    
    var title: String = ""
    var author: String?
    var pages: Int = 0
    var image: NSData?
    
    convenience init(title: String, author: String = "", pages: Int) {
        self.init()
        self.title = title
        self.author = author
        self.pages = pages
    }
}
