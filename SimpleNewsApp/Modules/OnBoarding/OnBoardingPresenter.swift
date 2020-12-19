//
//  Presenter.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/17/20.
//

import Foundation

protocol OnBoardingView: class {
    func fetchingCatagoriesSuccessfully()
    func fetchingCountriesSuccessfully()
    func showError(error: String)
    func navigateToHeadlinesVC(country: CountryName, categories: [CategoryName])
    func showAlert(title: String, message: String)
}

protocol OnBoardingCategoryCell {
    func displayName(name: String)
}

class OnBoardingPresenter {
    
    private weak var view: OnBoardingView?
    private let catagoriesInteractor = CategoriesInteractor()
    private let counrtriesInteractor = CountryManager() // TODO: Rename the class CountryManager
    private var categories = [ CategoryName]()
    private var selectedCategories = [ CategoryName]()
    private var selectedCountry: CountryName?
    private let requiredNumberOfSelectedCategories = 3
    private let alertRules = "Please choose a country and 3 favorite categories"
    private let alertTitle = "Required Info"

    init(view: OnBoardingView) {
        self.view = view
    }
    // MARK:- LifeCycle
    func viewDidLoad(){
        getCategories()
    }
    
    // MARK:- Categories
    func getCategories(){
        catagoriesInteractor.getCatagories { [weak self] (categories, error) in
            
            if let error = error {
                view?.showError(error: error.localizedDescription)
                return
            }
            
            self?.categories = categories
            self?.view?.fetchingCatagoriesSuccessfully()
            
        }
    }
    
    func getCategoriesCount() -> Int{
        return categories.count
    }
    
    
    func configure(cell: OnBoardingCategoryCell, for index: Int){
        if categories.indices.contains(index){
            cell.displayName(name: categories[index].capitalized) 
        }
    }
    
    func didSelectCategory(index: Int){
        selectedCategories.append(categories[index])
        debugLog("selected: \(categories[index])")
    }
    
    func didDeselectCategory(index: Int){
        selectedCategories.removeAll{ $0 == categories[index] }
        debugLog("deselected: \(categories[index])")
    }
    
    func didSelectMultipleCategories(indicies: [Int]){
        indicies.forEach{
            selectedCategories.append(categories[$0])
        }
        debugLog("multiple-selected indicies: \(indicies)")
    }
    
    // MARK:- Navigation
    func nextTapped(){
        if let selectionValidMessage = validateSelections(){
            debugLog(selectionValidMessage)
            view?.showAlert(title: alertTitle, message: "\(selectionValidMessage)\n\(alertRules)")
        }else {
            guard let selectedCountry = selectedCountry else { return }
            view?.navigateToHeadlinesVC(country: selectedCountry, categories: selectedCategories)
        }
    }
    
    // TODO: improve it to use errors
    fileprivate func validateSelections() -> String?{
        var message: String?
        guard let _ = selectedCountry else {
            message = "A country should be selected."
            return message
        }
        
        guard !selectedCategories.isEmpty else {
            message = "\(requiredNumberOfSelectedCategories) categories should be selected"
            return message
        }
        
        if selectedCategories.count != requiredNumberOfSelectedCategories {
            message = "Selected caregories number do not equal \(requiredNumberOfSelectedCategories)."
        }
        
        return message
    }
}
