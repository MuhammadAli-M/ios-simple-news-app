//
//  APIConstants.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/9/20.
//

import Foundation

typealias CountryCode = String

struct NewsAPIConstants {
    
    static let avaiableCountryCodes: [CountryCode] = ["ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph", "pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua", "us", "ve", "za"]
    
    static let avaiableCategories: [CategoryName] = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    
    static let dateFormat = "yyyy-mm-ddThh:mm:ssZ"
}

protocol Service {
    var baseUrl:String { get }
}

protocol NewsService: Service {
    var apiKey: String { get }
}

extension NewsService {
    var baseUrl:String { "https://newsapi.org" }
    var apiKey: String { "278f755dac054ab098bb406be3b4e2f2"}
}
