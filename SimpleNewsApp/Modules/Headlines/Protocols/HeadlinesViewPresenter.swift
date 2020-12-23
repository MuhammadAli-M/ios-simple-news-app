//
//  HeadlinesViewPresenter.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/21/20.
//

import Foundation

protocol HeadlinesViewPresenter {
    init(view: HeadlinesView, country: CountryName, categories: [CategoryName])
    func getTitle() -> String
    func getHeadlines()
    func getHeadlinesCount() -> Int
    func didSelectHeadline(at index: Int)
    func willDisplayHeadline(cell: HeadlinesCell, index: Int)
    func configure( cell: HeadlinesCell, index: Int)
    func searchBtnTapped()
}
