//
//  SearchResultsPresenter.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/24/20.
//

import Foundation

class SearchResultsPresenter: HeadlinesPresenter, SearchResultsViewPresenter {
    
    var searchText: String?
    
    required init(view: HeadlinesView,
                  country: CountryName,
                  categories: [CategoryName],
                  searchText: String) {
        super.init(view: view, country: country, categories: categories)
        self.searchText = searchText
    }
    
    required init(view: HeadlinesView, country: CountryName, categories: [CategoryName]) {
        super.init(view: view, country: country, categories: categories)
    }
    
    override func getHeadlines() {
        let group = DispatchGroup()
        guard let countryCode = CountryManager().codeForCountryName(country),
              let searchText = searchText else {return}
                
        categories.forEach{ category in
            group.enter()
            headlinesInteractor.getHeadlines(countryCode: countryCode,
                                                 category: category,
                                                 searchText: searchText) { [weak self ](newHeadlines, error) in
                self?.updateHeadlines(newHeadlines,
                                      category: category)
                group.leave()
            }
        }

        
        group.notify(queue: DispatchQueue.global()) { [weak self] in

            self?.headlines.sort { (first, second) -> Bool in
                first.date.compare(second.date) == .orderedDescending
            }
            
            self?.view?.fetchedHeadlinesSuccessfully()
        }
    }

}
