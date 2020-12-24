//
//  SearchResultsVC.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/24/20.
//

import UIKit

class SearchResultsVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var headlinesTable: UITableView!

    
    // MARK:- Properties
    private var tableHeadlines =  [Headline]()
    var categories: [CategoryName]?
    var country: CountryName?
    var presenter: SearchResultsViewPresenter!
    var searchText: String?
    private var vcTitle = "SearchResults"
    
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let country = country, let categories = categories else {return}
        presenter = SearchResultsPresenter(view: self,
                                       country: country,
                                       categories: categories,
                                       searchText: searchText ?? "") // TODO: refactor
        setupTitleAndBarButton()
        setupTableView(table: headlinesTable)
        presenter.getHeadlines()
    }

    // MARK:- Methods
    fileprivate func setupTitleAndBarButton() {
        title = vcTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        setSearchNavigaionBtn()
        addResetButton()
    }

    fileprivate func setSearchNavigaionBtn() {
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        button.tintColor = .label
        navigationItem.rightBarButtonItem = button
    }
    
    fileprivate func addResetButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelSearchTapped))
        button.tintColor = .label
        navigationItem.rightBarButtonItems?.append(button)
    }

    
    // MARK:- Actions
    @objc fileprivate func searchTapped(){
        debugLog("tapped")
        navigationController?.popViewController(animated: true)
    }
        
    @objc fileprivate func cancelSearchTapped(){
        if let parent = navigationController?.viewControllers.last(where: { (vc) -> Bool in
            vc is HeadlinesVC
        }) as? HeadlinesVC{
            debugLog("will navigate back to headlines vc")
            navigationController?.popToViewController(parent, animated: true)
        }else{
            debugLog("will navigate only to parent")
            navigationController?.popViewController(animated: true)
        }
    }
}


extension SearchResultsVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}
 
