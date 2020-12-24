//
//  SearchVC.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/19/20.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var searchTextField: UITextField!
        
    
    // MARK:- Properties
    private let searchResultsVCTitle = "Search Results"
    var categories: [CategoryName]?
    var country: CountryName?
    private var presenter: SearchViewPresenter!
    private let searchTextPlaceholder = "Search"
    
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let country = country, let categories = categories else { return }
        presenter = SearchPresenter(view: self, country: country, categories: categories)

        title = presenter.getTitle()
        self.searchTextField.delegate = self
        self.searchTextField.placeholder = searchTextPlaceholder
        self.searchTextField.becomeFirstResponder()
    }
    
    
    // MARK:- Actions
    
    
    // MARK:- Methods
}

// MARK: SearchVC + UITextFieldDelegate
extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        debugLog("")

        guard let text = textField.text, !text.isEmpty else {
            return false
        }
        debugLog("text is not empty: \(text)")
        presenter.searchEnd(withText: text)
        return true
    }
}

extension SearchVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}

