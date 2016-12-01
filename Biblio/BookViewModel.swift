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
    
    var currentPage: String {
        return pagesRead + " of " + totalPages
    }
    
    var totalPages: String {
        return String(book.totalPages)
    }
    
    var lastRead: String {
        guard let lastRead = book.lastRead
            else { return "Not read yet" }
        return DateFormatter.shortString(forDate: lastRead)
    }
    
    var finishBy: String {
        guard let finishDate = book.finishDate
            else { return "" }
        return DateFormatter.shortString(forDate: finishDate)
    }
    
    var image: Data? {
        return book.imageData
    }
    
    init(with book: Book) {
        self.book = book
    }
    
    /* This is not proper MVVM but I'm not yet sure how to subscribe to the events that trigger saves and deletes */
    public func save() {
        
    }
    
    public func delete() {
        
    }
}
