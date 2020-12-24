//
//  OnBoardingViewPresenter.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/24/20.
//

import Foundation

protocol OnBoardingViewPresenter {
    func viewDidLoad()
    func getCategories()
    func getCategoriesCount() -> Int
    func configure(cell: OnBoardingCategoryCell, for index: Int)
    func didSelectCategory(index: Int)
    func didDeselectCategory(index: Int)
    func didSelectMultipleCategories(indicies: [Int])
    func nextTapped()
    func getCountries()
    func getCountriesCount() -> Int
    func country(atIndex index: Int) -> CountryName
    func didSelectCountry(index: Int)
}
