//
//  IntObject.swift
//  Biblio
//
//  Created by Adam on 11/9/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import RealmSwift

class BoolObject: Object {
    dynamic var value = false
    
    convenience init(bool: Bool) {
        self.init()
        self.value = bool
    }
}
