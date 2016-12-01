//
//  BookTests.swift
//  Bibliio
//
//  Created by Adam on 12/1/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import XCTest
@testable import Bibliio

class BookTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBookDefaultValues() {
        let book = Book(title: "Robinson Cruscoe", author: "Daniel Defo", currentPage: 1, totalPages: 220)
        XCTAssertEqual(book.title, "Robinson Cruscoe")
        XCTAssertEqual(book.currentPage, 1)
        XCTAssertEqual(book.totalPages, 220)
        XCTAssertEqual(book.pagesPerDayGoal, 20)
        XCTAssertEqual(book.remindersOn, false)
        XCTAssertEqual(book.readingDays.reduce(true, {$0 && $1.value}), true)
        
        let daysBetweenTodayAndStart = Date.daysBetween(firstDate: book.startDate, secondDate: Date())!
        let daysUntilFinishDate = Date.daysBetween(firstDate: book.startDate, secondDate: book.finishDate!)!
        let days = Int(ceil(CGFloat(book.totalPages)/CGFloat(book.pagesPerDayGoal)))
        XCTAssertEqual(daysBetweenTodayAndStart, 0)
        XCTAssertEqual(daysUntilFinishDate, days)
    }
    
}
