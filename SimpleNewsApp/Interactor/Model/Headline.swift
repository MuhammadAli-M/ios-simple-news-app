//
//  Headline.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/22/20.
//

import Foundation

struct Headline{
    var title: String
    var source: String
    var date: Date
    var dateToString: ((Date) -> (String))
    var desc: String
    var url: String
    var imageUrlString: String?
    
    func dateString() -> String {
        return dateToString(date)
    }
}
