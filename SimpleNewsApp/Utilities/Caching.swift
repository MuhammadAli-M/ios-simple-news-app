//
//  Caching.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/13/20.
//

import Foundation

public enum UserDefaultsKey: String {
    case firstLanuch
    case selectedCountry
    case selectedCategories
}

struct Caching{
    let defaults = UserDefaults.standard
    
    func setKey(key: UserDefaultsKey, value: Any){
        defaults.set(value, forKey: key.rawValue)
    }
    
    func objectForKey(key: UserDefaultsKey) -> Any?{
        defaults.value(forKey: key.rawValue)
    }
    
    private static var sharedCaching: Caching = {
           return Caching()
       }()

       private init() {
       }

    static func shared() -> Caching {
           return sharedCaching
       }
}
