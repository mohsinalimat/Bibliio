//
//  ISBNService.swift
//  Bibliio
//
//  Created by Adam on 12/2/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import Foundation
import Keys

protocol PropertyListReadable {
    func propertyListRepresentation() -> Dictionary<String, String>
    init?(propertyListRepresentation: Dictionary<String, String>?)
}

struct ISBNService {

    var APIKey = ""
    
    init(_ key: String) {
        self.APIKey = key
    }
    
    public static func authenticatedISBNClient() -> ISBNService? {
        let defaults = UserDefaults.standard
        
        guard let data = defaults.object(forKey: Constants.ISBNService.CachedAuthenticatedAPIClientKey) as? Data else {
            guard let key = BibliioKeys().iSBNAPIKey() else {
                return nil
            }
            let client = ISBNService.init(key)
            let dictionaryRepresentation = client.propertyListRepresentation()
            let archivedData = NSKeyedArchiver.archivedData(withRootObject: dictionaryRepresentation)
            defaults.set(archivedData, forKey: Constants.ISBNService.CachedAuthenticatedAPIClientKey)
            return client
        }
        
        let dictionaryRepresentation: Dictionary<String, String> = NSKeyedUnarchiver.unarchiveObject(with: data) as! Dictionary<String, String>
        let client = ISBNService.init(propertyListRepresentation: dictionaryRepresentation)
        return client
    }
    
    func search(_ code: String, completion: (() -> ())?) {
        
        completion?()
    }
}

extension ISBNService: PropertyListReadable {
    
    func propertyListRepresentation() -> Dictionary<String, String> {
        return ["APIKey": self.APIKey]
    }
    
    init?(propertyListRepresentation: Dictionary<String, String>?) {
        
        guard let values = propertyListRepresentation else {
            return nil
        }
        
        if let APIKey = values["APIKey"] {
            self.APIKey = APIKey
        } else {
            return nil
        }
    }
    
}
