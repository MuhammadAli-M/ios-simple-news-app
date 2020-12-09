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
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleAndLabels()
        setupCountriesPicker()
        setupCategoriesTableView()
    }
    
    
    // MARK: Actions
    
    @objc func nextTapped(){
        if let selectionValidMessage = validateSelections(){
            debugLog(selectionValidMessage)
            let rules = "Please choose a country and 3 favorite categories"
            showAlert(title: "Required Info", message: "\(selectionValidMessage)\n\(rules)")
        }else {
            let vc = HeadlinesVC.instantiateVC()
            vc.modalPresentationStyle = .fullScreen
            let navigation = UINavigationController(rootViewController: vc)
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


extension OnBoardingVC: UIPickerViewDelegate, UIPickerViewDataSource{
    
    fileprivate func setupCountriesPicker() {
        countryPicker.delegate = self
        countryPicker.dataSource = self
        updatePickerSourceData()
    }

    fileprivate func updatePickerSourceData(){
        availableCountries = CountryManager().availableCountries()
        selectedCountry = availableCountries.first
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        availableCountries.count
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        availableCountries[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        debugLog("selected country: \(availableCountries[row])")
    }
}


extension OnBoardingVC: UITableViewDelegate, UITableViewDataSource{
    
    
    fileprivate func setupCategoriesTableView(){
        categoriesTable.register(UITableViewCell.self, forCellReuseIdentifier: CategoryCellReuseIdentifier)
        categoriesTable.delegate = self
        categoriesTable.dataSource = self
        categoriesTable.allowsMultipleSelection = true
        
        updateCategoriesTableSourceData()
    }
    
    
    fileprivate func updateCategoriesTableSourceData(){
        availableCategories =  NewsAPIConstants.avaiableCategories
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableCategories.count
    }
    
    
    // TODO: save strings in variables
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCellReuseIdentifier) ?? UITableViewCell()
        cell.textLabel?.text = availableCategories[indexPath.row]
        // TODO: improve the selection style
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategories.append(availableCategories[indexPath.row])
        debugLog("selected: \(availableCategories[indexPath.row])")
    }
    
    
    func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
        let rows = tableView.indexPathsForSelectedRows?.map({ $0.row })
        debugLog("multiple-selected indicies: \(String(describing: rows))")
        rows?.forEach{
            selectedCategories.append(availableCategories[$0])
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedCategories.removeAll{ $0 == availableCategories[indexPath.row] }
        debugLog("deselected: \(availableCategories[indexPath.row])")
    }
}


extension OnBoardingVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}
