//
//  HeadlinesVC+UITableView.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/17/20.
//

import UIKit


extension HeadlinesVC: UITableViewDelegate, UITableViewDataSource{
    
    func setupTableView(table: UITableView){
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getHeadlinesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.Id) as? HeadlineTableViewCell else {return UITableViewCell()}
        
        presenter.configure(cell: cell, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectHeadline(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let indicies = self.headlinesTable.indexPathsForVisibleRows, indicies.contains(indexPath) {
            
            guard let cell = cell as? HeadlineTableViewCell else {return}
            
            presenter.willDisplayHeadline(cell: cell, index:indexPath.row)
        }
    }
}
