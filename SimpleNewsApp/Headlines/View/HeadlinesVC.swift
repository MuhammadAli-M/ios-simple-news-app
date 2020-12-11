//
//  HeadlinesVC.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//


import UIKit
//typealias Headline = String

class HeadlinesVC: UIViewController {
    
    var newsHeadlines =  [HeadlineCellModel]()
    var categories: [CategoryName]?
    var country: CountryName?
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var headlinesTable: UITableView!
    
    var searchEnabled = false
    let searchVCTitle = "Search"
    let headlinesVCTitle = "Headlines"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextField.alpha = 0
        self.searchTextField.isHidden = true
        self.searchTextField.delegate = self
        setupTitleAndBarButton()
        setupTableView(table: headlinesTable)
        requestTopHeadlines()
    }
    
    
    fileprivate func setupTitleAndBarButton() {
        title = headlinesVCTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        button.tintColor = .label
        navigationItem.rightBarButtonItem = button
    }

    
    @objc func searchTapped(){
        debugLog("tapped")
        
        searchEnabled.toggle()
        enableSearchUI(show: searchEnabled)
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
    
    fileprivate func requestTopHeadlines() {
        let group = DispatchGroup()
        guard let categories = categories,
              let country = country,
              let countryCode = CountryManager().codeForCountryName(country) else {return}
        
        categories.forEach{ category in
            group.enter()
            HeadlinesService.shared.getHeadlines(countryCode: countryCode, category: category) { [weak self ](headlines, error) in
                self?.updateHeadlines(headlines, category: category)
                group.leave()
            }
        }

        group.notify(queue: DispatchQueue.global()) {
            self.newsHeadlines.sort { (first, second) -> Bool in
                first.date.compare(second.date) == .orderedDescending
            }
            DispatchQueue.main.async {
                self.headlinesTable.reloadData()
            }
        }
    }

    fileprivate func updateHeadlines(_ headlines: [Article], category: CategoryName) {
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
        newsHeadlines.append( contentsOf: cellModels)
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
        return newsHeadlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.Id) as? HeadlineTableViewCell else {return UITableViewCell()}
        
        cell.configure(model: newsHeadlines[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: newsHeadlines[indexPath.row].url) else { return }
        UIApplication.shared.open(url)

    }
    
}

extension HeadlinesVC: UITextFieldDelegate{
    
}

extension HeadlinesVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}

