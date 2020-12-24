//
//  SearchPresenter.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/23/20.
//

import Foundation

class SearchPresenter: SearchViewPresenter{
    var country = CountryName()
    var categories = [CategoryName]()
    private weak var view: SearchView?
    private let searchVCTitle = "Search"

    
    required init(view: SearchView, country: CountryName, categories: [CategoryName]){
        self.view = view
        self.country = country
        self.categories = categories
        
    }
    
    func getTitle() -> String{
        searchVCTitle
    }
    
    func searchEnd(withText text:String){
        debugLog("text: \(text)")
        view?.navigateToSearchResultsVC(searchText: text)
    }
    
    func cancelBtnTapped(){
        debugLog("")
    }
}
