//
//  Book.swift
//  Biblio
//
//  Created by Adam on 10/25/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RealmSwift

public class Book: Object {
    
    dynamic var title: String = ""
    dynamic var author: String = ""
    dynamic var totalPages: Int = 0
    dynamic var imageData: Data? = nil
    dynamic var progress: Progress!
    
    convenience init(title: String, author: String = "", currentPage: Int, totalPages: Int) {
        self.init()
        self.title = title
        self.author = author
        self.totalPages = totalPages
        self.progress = Progress(currentPage: currentPage, totalPages: totalPages)
    }
}
