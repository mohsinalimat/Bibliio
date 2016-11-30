//
//  BookViewModel.swift
//  Bibliio
//
//  Created by Adam on 11/30/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import Foundation

struct BookViewModel {
    
    // Input
    private var book: Book
    
    // Output
    var title: String {
        return book.title
    }
    
    var pagesRead: String {
        return String(book.currentPage)
    }
    
    var totalPages: String {
        return String(book.totalPages)
    }
    
    var lastRead: String {
        return ""
    }
    
    var finishBy: String {
        guard let finishDate = book.finishDate
            else { return "" }
        return DateFormatter.shortString(forDate: finishDate)
    }
    
    var image: String {
        return ""
    }
    
    
    init(with book: Book) {
        self.book = book
    }
    
}
