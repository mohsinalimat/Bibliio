//
//  DateExtensions.swift
//  Biblio
//
//  Created by Adam on 11/11/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

extension Date {
    
    static func ==(lhs: Date, rhs: Date) -> Bool {
        return lhs == rhs || lhs.compare(rhs) == .orderedSame
    }
    
    static func <(lhs: Date, rhs: Date) -> Bool {
        return lhs.compare(rhs) == .orderedAscending
    }
    
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    static func daysBetween(firstDate: Date, secondDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: Calendar.current.startOfDay(for: firstDate), to: Calendar.current.startOfDay(for: secondDate)).day
    }
    
}
