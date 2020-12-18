//
//  OnBoardingVC+OnBoardingView.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/17/20.
//

import Foundation

extension OnBoardingVC: OnBoardingView{
    func fetchingCatagoriesSuccessfully() {
        DispatchQueue.main.async {
            self.categoriesTable.reloadData()
        }
    }
    
    func fetchingCountriesSuccessfully() {
        // update picker view
    }
    
    func showError(error: String) {
        errorLog("presenter error: \(error)")
    }
    
    
}
