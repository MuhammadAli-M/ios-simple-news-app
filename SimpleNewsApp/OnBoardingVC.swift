//
//  OnBoardingVC.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//

import UIKit

typealias Category = String
typealias Country = String

class OnBoardingVC: UIViewController {
    
    var availableCountries = [Country]()
    var availableCategories = [Category]()
    
    var selectedCountry: Country?
    var selectedCategories: [Category]?
    
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var categoriesTable: UITableView!
    @IBOutlet weak var countrySelectionLabel: UILabel!
    @IBOutlet weak var categoriesSelectionLabel: UILabel!
    let CategoryCellReuseIdentifier = "CategoryTableCell"
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleAndLabels()
        setupCountriesPicker()
        setupCategoriesTableView()
    }
    
    
    // MARK: Actions
    
    @objc func nextTapped(){
        let vc = HeadlinesVC.instantiateVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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


extension OnBoardingVC: UIPickerViewDelegate, UIPickerViewDataSource{
    
    fileprivate func setupCountriesPicker() {
        countryPicker.delegate = self
        countryPicker.dataSource = self
        updatePickerSourceData()
    }

    fileprivate func updatePickerSourceData(){
        let availableCountryCodes = ["ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph", "pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua", "us", "ve", "za"]
        
        availableCountries = availableCountryCodes.compactMap{ code in
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id)
            return name
        }
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
        availableCategories = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
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
        selectedCategories?.append(availableCategories[indexPath.row])
        debugLog("selected: \(availableCategories[indexPath.row])")
    }
    
    
    func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
        let rows = tableView.indexPathsForSelectedRows?.map({ $0.row })
        debugLog("multiple-selected indicies: \(String(describing: rows))")
        rows?.forEach{
            selectedCategories?.append(availableCategories[$0])
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedCategories?.removeAll{ $0 == availableCategories[indexPath.row] }
        debugLog("deselected: \(availableCategories[indexPath.row])")
    }
}


extension OnBoardingVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}
