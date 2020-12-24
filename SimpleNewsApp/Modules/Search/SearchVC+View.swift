//
//  SearchVC+View.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/24/20.
//

import Foundation

extension SearchVC: SearchView{

    func navigateToSearchResultsVC(searchText: String){
        let vc = SearchResultsVC.instantiateVC()
        vc.country = country
        vc.categories = categories
        vc.searchText = searchText
        navigationController?.pushViewController(vc, animated: true)
    }
}
