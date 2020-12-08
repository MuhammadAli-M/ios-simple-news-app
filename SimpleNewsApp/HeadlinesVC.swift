//
//  HeadlinesVC.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//


import UIKit
typealias Headline = String

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
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsHeadlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellReuseIdentifier) ?? UITableViewCell()
        cell.textLabel?.text = newsHeadlines[indexPath.row]
        // TODO: improve the selection style
        return cell
    }
}



extension HeadlinesVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}
