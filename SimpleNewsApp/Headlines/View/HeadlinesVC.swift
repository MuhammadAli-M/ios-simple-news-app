//
//  HeadlinesVC.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//


import UIKit
//typealias Headline = String

class HeadlinesVC: UIViewController {
    
    let tableCellReuseIdentifier = "HeadlineCell" // TODO: rename it
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
                self?.updateHeadlines(headlines)
            }
        }
        
        
    }

    fileprivate func updateHeadlines(_ headlines: [Article]) {
        for headlineReponse in headlines {
            let title = headlineReponse.title
            let desc = headlineReponse.articleDescription
            let date = headlineReponse.publishedAt
            let sourceName = headlineReponse.source.name
            let model = HeadlineCellModel(title: title, source: sourceName, date: date.string(format: NewsAPIConstants.dateFormat) , desc: desc ?? "Nan", imageName: "") // FIXME: udpate image name properly
            newsHeadlines.append(model)
        }
        
        DispatchQueue.main.async {
            self.headlinesTable.reloadData()
        }
    }

}


extension HeadlinesVC: UITableViewDelegate, UITableViewDataSource{
    
    
    fileprivate func setupTableView(table: UITableView){
        table.register(UITableViewCell.self, forCellReuseIdentifier: tableCellReuseIdentifier)
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
    
}



extension HeadlinesVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}

