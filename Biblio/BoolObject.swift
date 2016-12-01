//
//  IntObject.swift
//  Bibliio
//
//  Created by Adam on 11/9/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import RealmSwift

// Wrapper object for bool primitive because Realm is dumb
class BoolObject: Object {
    dynamic var value = false
    
    convenience init(bool: Bool) {
        self.init()
        self.value = bool
    }
    
}
