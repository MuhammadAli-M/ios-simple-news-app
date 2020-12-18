//
//  OnBoardingVC.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//

import UIKit

typealias CategoryName = String
typealias CountryName = String

class OnBoardingVC: UIViewController {
    
    var availableCountries = [CountryName]()
    var availableCategories = [CategoryName]()
    
    var selectedCountry: CountryName?
    var selectedCategories = [CategoryName]()
    
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var categoriesTable: UITableView!
    @IBOutlet weak var countrySelectionLabel: UILabel!
    @IBOutlet weak var categoriesSelectionLabel: UILabel!
    let CategoryCellReuseIdentifier = "CategoryTableCell"
    let requiredNumberOfSelectedCategories = 3
    
    lazy var presenter = OnBoardingPresenter(view: self)
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleAndLabels()
        setupCountriesPicker()
        setupCategoriesTableView()
        presenter.viewDidLoad()
    }
    
    
    // MARK: Actions
    
    @objc func nextTapped(){
        if let selectionValidMessage = validateSelections(){
            debugLog(selectionValidMessage)
            let rules = "Please choose a country and 3 favorite categories"
            showAlert(title: "Required Info", message: "\(selectionValidMessage)\n\(rules)")
        }else {
            let vc = HeadlinesVC.instantiateVC()
            vc.categories = selectedCategories
            vc.country = selectedCountry
            let navigation = UINavigationController(rootViewController: vc)
            navigation.modalPresentationStyle = .fullScreen
            present(navigation, animated: true, completion: nil)
        }
    }
    
    // MARK: Methods
    
    fileprivate func setupTitleAndLabels() {
        title = "Welcome"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
        
        countrySelectionLabel.text = "Select Country"
        countrySelectionLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        
        categoriesSelectionLabel.text = "Select Category"
        categoriesSelectionLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        
    }
    
    // TODO: improve it to use errors
    fileprivate func validateSelections() -> String?{
        var message: String?
        guard let _ = selectedCountry, !selectedCategories.isEmpty else {
            message = "Required values have not been set."
            return message
        }
        
        if selectedCategories.count != requiredNumberOfSelectedCategories {
            message = "Selected caregories number do not equal \(requiredNumberOfSelectedCategories)."
        }
        
        return message
    }
}




extension OnBoardingVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}
