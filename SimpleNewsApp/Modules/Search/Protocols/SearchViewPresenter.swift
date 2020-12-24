//
//  SearchViewPresenter.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/23/20.
//

import Foundation

protocol SearchViewPresenter {
    init(view: SearchView, country: CountryName, categories: [CategoryName])
    func getTitle() -> String
    func searchEnd(withText text:String)
    func cancelBtnTapped()
}
