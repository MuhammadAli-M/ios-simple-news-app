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
    
    @IBOutlet weak var headlinesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitleAndBarButton()
        setupTableView(table: headlinesTable)
        requestTopHeadlines()
    }

    
    fileprivate func setupTitleAndBarButton() {
        title = "Headlines"
        navigationController?.navigationBar.prefersLargeTitles = true
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        button.tintColor = .label
        navigationItem.rightBarButtonItem = button
    }


    @objc func searchTapped(){
        debugLog("tapped")
    }
    
    fileprivate func requestTopHeadlines() {
        guard let categories = categories,
              let country = country,
              let countryCode = CountryManager().codeForCountryName(country) else {return}
        
        categories.forEach{ category in
            HeadlinesService.shared.getHeadlines(countryCode: countryCode, category: category) { [weak self ](headlines, error) in
                self?.updateHeadlines(headlines, category: category)
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
                                          imageUrl: imageUrl) // FIXME: udpate image name properly
            return model
        }
        newsHeadlines.append( contentsOf: cellModels)
        
        newsHeadlines.sort { (first, second) -> Bool in
            first.date.compare(second.date) == .orderedDescending
        }
        DispatchQueue.main.async {
            self.headlinesTable.reloadData()
        }
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



extension HeadlinesVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}

