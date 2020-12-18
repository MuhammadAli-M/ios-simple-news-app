//
//  OnBoarding+UITableView.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/18/20.
//

import UIKit

extension OnBoardingVC: UITableViewDelegate, UITableViewDataSource{
    
    func setupCategoriesTableView(){
        categoriesTable.delegate = self
        categoriesTable.dataSource = self
        categoriesTable.allowsMultipleSelection = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCategoriesCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnBoardingTableViewCell.id) as? OnBoardingTableViewCell else { return UITableViewCell() }
        
        // TODO: improve the selection style
        presenter.configure(cell: cell, for: indexPath.row)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectCategory(index: indexPath.row)
    }
    
    
    func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
        guard let rows = tableView.indexPathsForSelectedRows?.map({ $0.row }) else {return}
        presenter.didSelectMultipleCategories(indicies: rows)
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        presenter.didDeselectCategory(index: indexPath.row)
    }
}
