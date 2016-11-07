//
//  DateFormatter.swift
//  Biblio
//
//  Created by Adam on 11/7/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

extension DateFormatter {
    
    private static let bookDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    
    static func string(forDate: Date) {
        
    }
}
