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
        DispatchQueue.main.async {
            self.countryPicker.reloadAllComponents()
            self.presenter.didSelectCountry(index: 0)
        }
    }
    
    func showError(error: String) {
        errorLog("presenter error: \(error)")
    }
    
}
