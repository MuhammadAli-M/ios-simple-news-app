//
//  HeadlinesVC.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//


import UIKit

class HeadlinesVC: UIViewController {

    @IBOutlet weak var headlinesTable: UITableView!

    private var tableHeadlines =  [Headline]()
    var categories: [CategoryName]?
    var country: CountryName?
    var presenter: HeadlinesViewPresenter! // TODO: think of refactoring the presenter initialization

    private let headlinesVCTitle = "Headlines"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let vc = SearchVC.instantiateVC()
        vc.country = country
        vc.categories = categories
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HeadlinesVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}

