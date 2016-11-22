//
//  BookListCellViewModel.swift
//  Bibliio
//
//  Created by Adam on 11/17/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

import RxSwift
import RxRealm

struct BookListCellViewModel {
    
    // Input
    var book: Observable<Book>!
    
    // Output
    var title: Observable<String>!
    var pagesRead: Observable<String>!
    var lastRead: Observable<String>!
    var finishBy: Observable<String>!
    var read: Observable<String>!
    var image: Observable<UIImage?>!
        
    init(with book: Book) {
        self.book = Observable.from(book)
        title = self.book.map { (book) in
            return book.title
        }
        pagesRead = self.book.map { (book) in
            return "\(book.currentPage)"
        }
        lastRead = self.book.map { (book) in
            guard let lastRead = book.lastRead
                else { return "" }
            return "\(DateFormatter.shortString(forDate: lastRead))"
        }
        finishBy = self.book.map { (book) in
            guard let finishDate = book.finishDate
                else { return "" }
            return "\(DateFormatter.shortString(forDate: finishDate))"
        }
        image = self.book.map { (book) in
            guard let imageData = book.imageData
                else { return nil }
            return UIImage(data: imageData)
        }
    }
    
}
