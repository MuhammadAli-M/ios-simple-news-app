//
//  HeadlinesVC.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//


import UIKit
//typealias Headline = String

protocol HeadlinesModel {
    var headlines: [HeadlineCellModel] { get set}
}

class SearchHeadlinesModel: HeadlinesModel {
    var headlines = [HeadlineCellModel]()
    var searchText: String
    
    init(searchText: String){
        self.searchText = searchText
    }
}

class FeedHeadlinesModel: HeadlinesModel {
    var headlines = [HeadlineCellModel]()
}

class HeadlinesVC: UIViewController {
    
    private var tableHeadlines =  [HeadlineCellModel]()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextField.alpha = 0
        self.searchTextField.isHidden = true
        self.searchTextField.delegate = self
        setupTitleAndBarButton()
        setupTableView(table: headlinesTable)
        requestHeadlines()
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
    
    // TODO: refactor this method to separate the UI & logic handling
    fileprivate func requestHeadlines(_ searchText: String? = nil) {
        let group = DispatchGroup()
        guard let categories = categories,
              let country = country,
              let countryCode = CountryManager().codeForCountryName(country) else {return}
        
        var model: HeadlinesModel = feedHeadlinesModel
        // TODO: finsih it
        if let searchText = searchText {
            model = SearchHeadlinesModel(searchText: searchText)
            searchHeadlinesModel = model
            isSearchResultsShown = true
        }
        
        categories.forEach{ category in
            group.enter()
            HeadlinesService.shared.getHeadlines(countryCode: countryCode,
                                                 category: category,
                                                 searchText: searchText) { [weak self ](headlines, error) in
                self?.updateHeadlines(headlinesSource: &model.headlines ,
                                      headlines,
                                      category: category)
                group.leave()
            }
        }

        
        group.notify(queue: DispatchQueue.global()) {
            self.tableHeadlines = model.headlines

            self.tableHeadlines.sort { (first, second) -> Bool in
                first.date.compare(second.date) == .orderedDescending
            }
            DispatchQueue.main.async {
                self.headlinesTable.reloadData()
            }
        }
    }

    fileprivate func updateHeadlines(headlinesSource: inout [HeadlineCellModel] ,
                                     _ headlines: [Article],
                                     category: CategoryName) {
        let cellModels = headlines.map{ headlineReponse -> HeadlineCellModel in
            let title = headlineReponse.title
            let desc = headlineReponse.articleDescription
            let date = headlineReponse.publishedAt
            let sourceName = headlineReponse.source.name
            let url = headlineReponse.url
            let imageUrl = headlineReponse.urlToImage
            let model = HeadlineCellModel(title: title,
                                          source: sourceName + " | " + category.capitalized, // TODO: Localization
                                          date: date,
                                          dateToString:  { (someDate: Date) -> String in
                                                            someDate.string(format: "MMM d, h:mm a")},
                                          desc: desc ?? "",
                                          url: url,
                                          imageUrlString: imageUrl ?? "") // FIXME: udpate image name properly
            return model
        }
        headlinesSource.append( contentsOf: cellModels)
    }

}


extension HeadlinesVC: UITableViewDelegate, UITableViewDataSource{
    
    
    fileprivate func setupTableView(table: UITableView){
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 200
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableHeadlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.Id) as? HeadlineTableViewCell else {return UITableViewCell()}
        
        cell.configure(model: tableHeadlines[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: tableHeadlines[indexPath.row].url) else { return }
        UIApplication.shared.open(url)

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let indicies = self.headlinesTable.indexPathsForVisibleRows, indicies.contains(indexPath) {
            
            guard let cell = cell as? HeadlineTableViewCell else {return}
            
            cell.configImage(urlString: tableHeadlines[indexPath.row].imageUrlString)
        }
    }
}

extension HeadlinesVC: HeadlineTableViewCellDelegate{
    func cell(urlString: String , updatesFavoriteState isFavorite: Bool) {
        let model = tableHeadlines.first{ $0.url == urlString }
        // TODO: save it
        debugLog(model?.title ?? "")
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
        requestHeadlines(searchText)
        searchEnabled = false
        enableSearchUI(show: searchEnabled)
        title = searchResultsVCTitle
        addResetButton()
    }
}

extension HeadlinesVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}
