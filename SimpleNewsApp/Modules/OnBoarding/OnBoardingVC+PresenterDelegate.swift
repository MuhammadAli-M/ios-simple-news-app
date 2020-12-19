//
//  OnBoardingVC+OnBoardingView.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/17/20.
//

import UIKit

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
    
    func navigateToHeadlinesVC(country: CountryName, categories: [CategoryName]){
        let vc = HeadlinesVC.instantiateVC()
        vc.categories = categories
        vc.country = country
        let navigation = UINavigationController(rootViewController: vc)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true, completion: nil)
    }
}
