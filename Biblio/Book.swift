//
//  Book.swift
//  Biblio
//
//  Created by Adam on 10/25/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

class Book: NSObject {
    
    var title: String
    var author: String?
    var pages: Int
    var progress: Progress?
    
    init(title: String, author: String = "", pages: Int) {
        self.title = title
        self.author = author
        self.pages = pages
        super.init()
    }
}
