//
//  HeadlinesVC+ViewPresenter.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/21/20.
//

import UIKit

extension HeadlinesVC : HeadlinesView{
    
    func fetchedHeadlinesSuccessfully() {
        DispatchQueue.main.async {
            self.headlinesTable.reloadData()
        }
    }
    
    func openUrl(_ url: URL) {
        UIApplication.shared.open(url)
    }
}
