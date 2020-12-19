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
    // TODO: remove after refactoring the picker view
    var availableCountries = [CountryName]()
    var selectedCountry: CountryName?
    
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var categoriesTable: UITableView!
    @IBOutlet weak var countrySelectionLabel: UILabel!
    @IBOutlet weak var categoriesSelectionLabel: UILabel!

    
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
        presenter.nextTapped()
        
    }
    
    func navigateToHeadlinesVC(country: CountryName, categories: [CategoryName]){
        let vc = HeadlinesVC.instantiateVC()
        vc.categories = categories
        vc.country = country
        let navigation = UINavigationController(rootViewController: vc)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true, completion: nil)
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
}




extension OnBoardingVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}
