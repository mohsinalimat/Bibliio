//
//  ArrayExtensions.swift
//  Biblio
//
//  Created by Adam on 11/1/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

extension Array where Element: Equatable {
    
    mutating func arrayByRemoving(object: Element) -> [Element] {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
        return self
    }
}
