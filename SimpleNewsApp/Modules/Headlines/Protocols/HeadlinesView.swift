//
//  HeadlinesView.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/21/20.
//

import Foundation

protocol HeadlinesView: class {
    var country: CountryName? { get set}
    var categories: [CategoryName]? { get set}
    func fetchedHeadlinesSuccessfully()
    func openUrl(_ url: URL)
}
