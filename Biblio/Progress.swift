//
//  Progress.swift
//  Biblio
//
//  Created by Adam on 10/25/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RealmSwift

class Progress: Object {
    
    dynamic var currentPage: Int = 0
    dynamic var totalPages: Int = 0
    dynamic var startDate: Date = Date()
    dynamic var finishDate: Date = Date()
    dynamic var lastRead = Date()
    dynamic var pagesPerDayGoal = 10
    
    var percentage: CGFloat {
        get {
            return CGFloat(currentPage/totalPages)
        }
    }
    
    convenience init(currentPage: Int, totalPages: Int) {
        self.init()
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.startDate = Date()
        finishDate = calculateFinishDate()
    }
    
    func updateLastRead() {
        lastRead = Date()
    }
    
    func calculateFinishDate() -> Date {
        return Date()
    }
}
