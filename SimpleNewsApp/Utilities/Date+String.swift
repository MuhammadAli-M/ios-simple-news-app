//
//  Date+String.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/9/20.
//

import Foundation


extension Date{
    func string(format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
