//
//  CategoriesInteractor.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/17/20.
//

import Foundation

class CategoriesInteractor{
    func getCatagories(completeionHandler: (([CategoryName], Error?) -> Void)){
        
        completeionHandler( NewsAPIConstants.avaiableCategories, nil)
        
    }
}
