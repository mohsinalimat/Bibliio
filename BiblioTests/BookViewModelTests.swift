//
//  BookViewModelTests.swift
//  Bibliio
//
//  Created by Adam on 11/30/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import XCTest
@testable import Bibliio

class BookViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testBookViewModel() {
        let book = Book(title: "Green Eggs & Ham", author: "Dr. Seuss", currentPage: 1, totalPages: 40)
        let bookViewModel = BookViewModel(with: book)
        XCTAssertEqual(bookViewModel.title, book.title)
        XCTAssertEqual(bookViewModel.pagesRead, "1")
        XCTAssertEqual(bookViewModel.lastRead, "")
        XCTAssertEqual(bookViewModel.finishBy, DateFormatter.shortString(forDate:book.finishDate!))
    }
    
}
