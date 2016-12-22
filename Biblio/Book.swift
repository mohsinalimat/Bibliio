//
//  Book.swift
//  Bibliio
//
//  Created by Adam on 10/25/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import RealmSwift
import UserNotifications

class Book: Object {
    
    // MARK: - Properties
    
    private(set) dynamic var id = NSUUID().uuidString
    
    dynamic var title: String = ""
    dynamic var author: String = ""
    dynamic var totalPages: Int = 1
    dynamic var startDate = Date()
    dynamic var finishDate: Date? {
        return estimatedFinishDate()
    }
    dynamic var lastRead: Date?
    dynamic var pagesPerDayGoal = 20
    let readingDays = List<BoolObject>()
    dynamic var imageData: Data? = nil
    
    private dynamic var currentPageBacking: Int = 1
    dynamic var currentPage: Int {
        get {
            return currentPageBacking
        }
        set(newValue) {
            currentPageBacking = newValue
            updateLastRead()
        }
    }
    private dynamic var remindersOnBacking: Bool = false
    dynamic var remindersOn: Bool {
        get {
            return remindersOnBacking
        }
        set(newValue) {
            remindersOnBacking = newValue
            enableReminders(remindersOnBacking)
        }
    }
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
    
    // MARK: - Initialization
    
    convenience init(title: String, author: String = "", currentPage: Int, totalPages: Int) {
        self.init()
        self.title = title
        self.author = author
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.readingDays.append(objectsIn: [BoolObject(bool: true), BoolObject(bool: true), BoolObject(bool: true), BoolObject(bool: true), BoolObject(bool: true), BoolObject(bool: true), BoolObject(bool: true)])
    }
    
    convenience init?(_ json: [String: Any]) {
        self.init()
        guard let title = json["title"] as? String else {
            return nil
        }
        guard let authors = json["authors"] as? [Any] else {
            return nil
        }
        guard let author = authors.first as? String else {
            return nil
        }
        guard let totalPages = json["pageCount"] as? Int else {
            return nil
        }
        self.title = title
        self.author = author
        self.totalPages = totalPages
        self.readingDays.append(objectsIn: [BoolObject(bool: true), BoolObject(bool: true), BoolObject(bool: true), BoolObject(bool: true), BoolObject(bool: true), BoolObject(bool: true), BoolObject(bool: true)])
    }
    
    // MARK: - Public
    
    func configureSchedule(for date: Date) {
        guard let days = Date.daysBetween(firstDate: Date(), secondDate: date)
            else { return }
        let pagesLeft = totalPages - currentPage
        var daysUntilGoal = days
        if days > pagesLeft {
            daysUntilGoal = pagesLeft
        }
        let pagesPerDay = ceil(CGFloat(pagesLeft)/CGFloat(daysUntilGoal))
        let _ = readingDays.map { $0.value = true }
        pagesPerDayGoal = Int(pagesPerDay)
    }
    
    // MARK: - Overrides
    
    override static func ignoredProperties() -> [String] {
        return ["remindersOn"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: - Private
    
    private func updateLastRead() {
        lastRead = Date()
    }
    
    private func estimatedFinishDate() -> Date? {
        let today = Date()
        var daysLeft = 0
        var pagesSum = currentPage
        var currentDay = today.dayNumberOfWeek()! - 1
        
        while (pagesSum <= totalPages) {
            if readingDays[currentDay].value {
                pagesSum = pagesSum + pagesPerDayGoal
            }
            daysLeft += 1
            currentDay = currentDay == 6 ? 0 : currentDay + 1
        }
        
        let calendar = Calendar.current
        var components = DateComponents()
        components.day = daysLeft
        
        return calendar.date(byAdding: components, to: today)
    }
    
    //This doesn't work or belong here. Just a reminder to myself so I'll keep grimacing when I see this, and hopefully, eventually, do something. when i have at least 1 user, I'll fix this, promise.
    private func enableReminders(_ enable: Bool) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        if enable == true {
            var components = DateComponents()
            components.hour = 13
            let content = UNMutableNotificationContent()
            content.body = "Hey, don't forget to read \(title) 📖"
            let trigger = UNCalendarNotificationTrigger.init(dateMatching: DateComponents(), repeats: true)
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                print("\(error.debugDescription)")
            }
        }
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
        book.remindersOn = self.remindersOn
        return book
    }
    
}
