//
//  HeadlinesVC.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//


import UIKit
//typealias Headline = String

protocol HeadlinesModel {
    var headlines: [Headline] { get set}
}

class SearchHeadlinesModel: HeadlinesModel {
    var headlines = [Headline]()
    var searchText: String
    
    init(searchText: String){
        self.searchText = searchText
    }
}

class FeedHeadlinesModel: HeadlinesModel {
    var headlines = [Headline]()
}

class HeadlinesVC: UIViewController {
    
    private var tableHeadlines =  [Headline]()
    var categories: [CategoryName]?
    var country: CountryName?
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var headlinesTable: UITableView!
    
    private var searchEnabled = false
    private let searchVCTitle = "Search"
    private let headlinesVCTitle = "Headlines"
    private let searchResultsVCTitle = "Search Results"
    private var searchHeadlinesModel: HeadlinesModel?
    private var feedHeadlinesModel: HeadlinesModel = FeedHeadlinesModel()
    private var isSearchResultsShown = false
    
    // TODO: think of refactoring the presenter initialization
    var presenter: HeadlinesViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextField.alpha = 0
        self.searchTextField.isHidden = true
        self.searchTextField.delegate = self
        guard let country = country, let categories = categories else {return}
        presenter = HeadlinesPresenter(view: self,
                                       country: country,
                                       categories: categories)
        setupTitleAndBarButton()
        setupTableView(table: headlinesTable)
        presenter.getHeadlines()
    }
    
    
    fileprivate func setSearchNavigaionBtn() {
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        button.tintColor = .label
        navigationItem.rightBarButtonItem = button
    }
    
    fileprivate func setupTitleAndBarButton() {
        title = headlinesVCTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        setSearchNavigaionBtn()
    }

    
    @objc fileprivate func searchTapped(){
        debugLog("tapped")
        setSearchNavigaionBtn()
        searchEnabled.toggle()
        enableSearchUI(show: searchEnabled)
        isSearchResultsShown = false
    }
    
    fileprivate func addResetButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelSearchTapped))
        button.tintColor = .label
        navigationItem.rightBarButtonItems?.append(button)

    }
    
    @objc fileprivate func cancelSearchTapped(){
        title = headlinesVCTitle
        tableHeadlines = feedHeadlinesModel.headlines
        headlinesTable.reloadData()
        isSearchResultsShown = false
        navigationItem.rightBarButtonItems?.removeAll()
        setSearchNavigaionBtn()
    }
    
    
    fileprivate func enableSearchUI(show: Bool) {
        let fadeTextAnimation = CATransition()
        fadeTextAnimation.duration = 0.5
        fadeTextAnimation.type = .fade
        
        navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: nil)
        navigationItem.title = show ? self.searchVCTitle : self.headlinesVCTitle
        
        self.searchTextField.text = ""
        
        // TODO: refactor repeated code
        _ = show ? self.searchTextField.becomeFirstResponder() :  self.searchTextField.resignFirstResponder()
        _ = show ? self.headlinesTable.resignFirstResponder() : self.headlinesTable.becomeFirstResponder()
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            
            self.searchTextField.alpha = show ? 1: 0
            self.searchTextField.isHidden = !show
            self.headlinesTable.isHidden = show
            
        }completion: { (_) in}
    }
}

extension HeadlinesVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        debugLog("request")
        
        guard let text = textField.text, !text.isEmpty else {
            return false
        }
        
        requestSearchForHeadlines(text)
        
        return true
    }
    
    
    fileprivate func requestSearchForHeadlines(_ searchText: String){
//        requestHeadlines(searchText)
        searchEnabled = false
        enableSearchUI(show: searchEnabled)
        title = searchResultsVCTitle
        addResetButton()
    }
}

extension HeadlinesVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}

