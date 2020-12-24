//
//  OnBoardingView.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/24/20.
//

import Foundation

protocol OnBoardingView: class {
    func fetchingCatagoriesSuccessfully()
    func fetchingCountriesSuccessfully()
    func showError(error: String)
    func navigateToHeadlinesVC(country: CountryName, categories: [CategoryName])
    func showAlert(title: String, message: String)
}
