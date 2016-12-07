//
//  ISBNService.swift
//  Bibliio
//
//  Created by Adam on 12/2/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import Foundation
import Keys

enum APIClientError: Error {
    case jsonError
    case serverError
    case invalidContentType
    case invalidCredentials
    case invalidParameters
}

protocol PropertyListReadable {
    func propertyListRepresentation() -> Dictionary<String, String>
    init?(propertyListRepresentation: Dictionary<String, String>?)
}

struct APIClient {
    
    var APIKey = ""
    
    private var baseURL: URL? {
        return URL(string: "https://www.googleapis.com/books/v1/")
    }
    
    init(_ key: String) {
        self.APIKey = key
    }
    
    public static func authenticatedAPIClient() -> APIClient? {
        
        let defaults = UserDefaults.standard
        
        guard let data = defaults.object(forKey: Constants.APIClient.CachedAuthenticatedAPIClientKey) as? Data else {
            guard let key = BibliioKeys().booksAPIKey() else {
                return nil
            }
            let client = APIClient.init(key)
            let dictionaryRepresentation = client.propertyListRepresentation()
            let archivedData = NSKeyedArchiver.archivedData(withRootObject: dictionaryRepresentation)
            defaults.set(archivedData, forKey: Constants.APIClient.CachedAuthenticatedAPIClientKey)
            return client
        }
        
        let dictionaryRepresentation: Dictionary<String, String> = NSKeyedUnarchiver.unarchiveObject(with: data) as! Dictionary<String, String>
        let client = APIClient.init(propertyListRepresentation: dictionaryRepresentation)
        return client
    }
    
    func search(_ code: String, success: ((_ book: Book) -> ())?, failure: ((_ error: APIClientError) -> ())?) {
        
        guard let baseURL = self.baseURL else {
            return
        }
        
        guard let url = URL(string: "volumes?q=isbn:\(code)&key=\(self.APIKey)", relativeTo: baseURL) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            let httpResponse = response as! HTTPURLResponse
            let code = httpResponse.statusCode
           
            if code >= 200 && code <= 300 {
            
                guard let unwrappedData = data else {
                    DispatchQueue.main.async {
                        failure?(APIClientError.jsonError)
                    }
                    return
                }
                
                do {
                    let responseDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                    print(responseDictionary)
                } catch let e {
                    print("\(e.localizedDescription)")
                }
                
            } else if code >= 400 && code < 500 {
                DispatchQueue.main.async {
                    failure?(APIClientError.invalidCredentials)
                }
            } else {
                DispatchQueue.main.async {
                    
                }
            }
        })
        
        task.resume()
    }
}

extension APIClient: PropertyListReadable {
    
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
