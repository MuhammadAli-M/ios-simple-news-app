//
//  HeadlinesURL.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/9/20.
//

import Foundation


struct HeadlinesURL{
    let baseUrl: String
    var queries: [HeadlineQuery]
    
    var url: URL?{
        guard let url = URL(string: baseUrl) else {return nil}
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {return nil}
        
        components.queryItems = queries.map{
            URLQueryItem(name: $0.key.rawValue, value: $0.value)
        }
        return components.url
    }
    
}


struct HeadlineQuery {
    let key:HeadlineQueryKey
    let value:String
}

enum HeadlineQueryKey: String {
    case country
    case category
    case sources
    case q
    case pageSize
    case page
    case apiKey
}
