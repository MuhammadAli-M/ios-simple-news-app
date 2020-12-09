//
//  CountryManager.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/9/20.
//

import Foundation

class CountryManager {
    
    private struct Country{
        let code: CountryCode
        let name: String
    }
    
    lazy private var countries = [Country]()
    
    init() {
        updateCountries()
    }
    
    private func updateCountries() {
        countries = NewsAPIConstants.avaiableCountryCodes.compactMap { (code) -> Country? in
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            guard let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) else { return nil}
            return Country(code: code, name: name)
        }
    }
    
    func availableCountries() -> [String]{
        return countries.map{ $0.name}
    }
    
    func codeForCountryName(_ name: String) -> CountryCode? {
        countries.first{ $0.name == name}?.code
    }
}
