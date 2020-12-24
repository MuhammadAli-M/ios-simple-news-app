//
//  SearchView.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/23/20.
//

import Foundation

protocol SearchView: class {
    var country: CountryName? { get set}
    var categories: [CategoryName]? { get set}
    func navigateToSearchResultsVC(searchText: String)
}
