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
    
    dynamic var title: String = ""
    dynamic var author: String = ""
    dynamic var pages: Int = 0
    dynamic var imageData: Data? = nil
    
    convenience init(title: String, author: String = "", pages: Int) {
        self.init()
        self.title = title
        self.author = author
        self.pages = pages
    }
}
