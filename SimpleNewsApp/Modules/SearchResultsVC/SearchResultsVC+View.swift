//
//  SearchResultsVC+View.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/24/20.
//

import UIKit


extension SearchResultsVC: SearchResultsView{

    func fetchedHeadlinesSuccessfully() {
        DispatchQueue.main.async {
             self.headlinesTable.reloadData()
        }
    }
    
    func openUrl(_ url: URL) {
        UIApplication.shared.open(url)
    }
}
