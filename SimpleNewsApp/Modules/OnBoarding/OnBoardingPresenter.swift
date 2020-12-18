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

    init(view: OnBoardingView) {
        self.view = view
    }
    
    func viewDidLoad(){
        getCategories()
    }
    
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
}
