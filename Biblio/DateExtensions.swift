//
//  DateExtensions.swift
//  Bibliio
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
    
    public func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    public static func daysBetween(firstDate: Date, secondDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: Calendar.current.startOfDay(for: firstDate), to: Calendar.current.startOfDay(for: secondDate)).day
    }
    
    static func nameOfDay(forIndex index: Int) -> String {
        switch index {
        case 0:
            return "Sunday"
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        default:
            return ""
        }
    }
    
}
