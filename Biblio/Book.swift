//
//  Book.swift
//  Biblio
//
//  Created by Adam on 10/25/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import RealmSwift

class Book: Object {
    
    private(set) dynamic var id = NSUUID().uuidString
    
    dynamic var title: String = ""
    dynamic var author: String = ""
    
    dynamic var currentPage: Int = 1
    dynamic var totalPages: Int = 1
    
    dynamic var startDate = Date()
    dynamic var finishDate: Date? {
        get {
            return estimatedFinishDate()
        }
    }
    dynamic var lastRead: Date?
    dynamic var pagesPerDayGoal = 10
    let readingDays = List<BoolObject>()
    dynamic var imageData: Data? = nil
    
    var percentCompleted: CGFloat {
        get {
            return CGFloat(currentPage)/CGFloat(totalPages)
        }
    }
    
    var isFinished: Bool {
        get {
           return currentPage == totalPages
        }
    }
    
    convenience init(title: String, author: String = "", currentPage: Int, totalPages: Int) {
        self.init()
        self.title = title
        self.author = author
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.readingDays.append(objectsIn: [BoolObject(bool: true), BoolObject(bool: false), BoolObject(bool: false), BoolObject(bool: false), BoolObject(bool: false), BoolObject(bool: false), BoolObject(bool: true)])
    }
    
    func updateLastRead() {
        lastRead = Date()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private func estimatedFinishDate() -> Date? {
        let readingDaysCount = readingDays.filter({ $0.value == true }).count
        let daysLeft = Int(ceil(CGFloat((totalPages - currentPage))/CGFloat(pagesPerDayGoal)))
        let weeksLeft = Int(ceil(CGFloat(daysLeft)/CGFloat(readingDaysCount)))
        let calendar = Calendar.current
        var components = DateComponents()
        components.weekOfYear = weeksLeft
        let finishDate = calendar.date(byAdding: components, to: Date())
        return finishDate
    }
    
}

extension Book: NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        let book = Book()
        book.title = self.title
        book.author = self.author
        book.currentPage = self.currentPage
        book.totalPages = self.totalPages
        book.startDate = self.startDate
        book.pagesPerDayGoal = self.pagesPerDayGoal
        book.readingDays.append(objectsIn: self.readingDays)
        book.lastRead = self.lastRead
        book.pagesPerDayGoal = self.pagesPerDayGoal
        book.imageData = self.imageData
        return book
    }
    
}
