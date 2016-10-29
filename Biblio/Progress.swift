//
//  Progress.swift
//  Biblio
//
//  Created by Adam on 10/25/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

class Progress: NSObject {
    
    var book: Book
    var currentPage: Int
    var startDate: Date
    var finishDate: Date
    
    init(book: Book, currentPage: Int) {
        self.book = book
        self.currentPage = currentPage
        startDate = Date()
        finishDate = Date()
        super.init()
    }
}
