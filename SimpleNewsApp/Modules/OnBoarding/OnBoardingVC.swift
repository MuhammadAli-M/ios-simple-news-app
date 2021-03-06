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
    
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var categoriesTable: UITableView!
    @IBOutlet weak var countrySelectionLabel: UILabel!
    @IBOutlet weak var categoriesSelectionLabel: UILabel!

    
    var presenter: OnBoardingViewPresenter!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = OnBoardingPresenter(view: self)
        setupTitleAndLabels()
        setupCountriesPicker()
        setupCategoriesTableView()
        presenter.viewDidLoad()
    }
    
    // MARK: Actions
    @objc func nextTapped(){
        presenter.nextTapped()
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
