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
    var newsHeadlines = ["Yes", "No"]//[Headline]()
    
    @IBOutlet weak var headlinesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleAndBarButton()

        setupTableView(table: headlinesTable)
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
        cell.title.text = newsHeadlines[indexPath.row]
        cell.source.text = "CNN"
        cell.headlineImage.image = UIImage(named: "img2")
        cell.date.text = "12 - 12 - 2020"
        cell.desc.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. "
        return cell
    }
    
}



extension HeadlinesVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}

