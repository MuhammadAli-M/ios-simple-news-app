//
//  HeadlinesPresenter.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/19/20.
//

import Foundation


class HeadlinesPresenter: HeadlinesViewPresenter{
    var country: CountryName
    var categories: [CategoryName]
    weak var view:HeadlinesView?
    var headlines = [Headline]()
    var headlinesInteractor = HeadlinesService.shared
        
    required init(view: HeadlinesView, country: CountryName, categories: [CategoryName]) {
        self.view = view
        self.country = country
        self.categories = categories
    }
    
    func getTitle() -> String {
        return "Headlines"
    }

    // TODO: refactor this method to separate the UI & logic handling
    func getHeadlines() {
        let group = DispatchGroup()
        guard let countryCode = CountryManager().codeForCountryName(country) else {return}
                
        categories.forEach{ category in
            group.enter()
            headlinesInteractor.getHeadlines(countryCode: countryCode,
                                                 category: category) { [weak self ](newHeadlines, error) in
                self?.updateHeadlines(newHeadlines,
                                      category: category)
                group.leave()
            }
        }

        
        group.notify(queue: DispatchQueue.global()) { [weak self] in

            self?.headlines.sort { (first, second) -> Bool in
                first.date.compare(second.date) == .orderedDescending
            }
            
            self?.view?.fetchedHeadlinesSuccessfully()
        }
    }

    func updateHeadlines(_ newHeadlines: [Article],
                                     category: CategoryName) {
        
        
        let cellModels = newHeadlines.map{ headlineReponse -> Headline in
            let title = headlineReponse.title
            let desc = headlineReponse.articleDescription
            let date = headlineReponse.publishedAt
            let sourceName = headlineReponse.source.name
            let url = headlineReponse.url
            let imageUrl = headlineReponse.urlToImage
            let model = Headline(title: title,
                                          source: sourceName + " | " + category.capitalized, // TODO: Localization
                                          date: date,
                                          dateToString:  { (someDate: Date) -> String in
                                                            someDate.string(format: "MMM d, h:mm a")},
                                          desc: desc ?? "",
                                          url: url,
                                          imageUrlString: imageUrl ?? "") // FIXME: udpate image name properly
            return model
        }

        headlines.append( contentsOf: cellModels)
    }
    
    
    func searchBtnTapped() {
        debugLog("")
    }
}

// MARK: Headlines Data Source
extension HeadlinesPresenter{
    
    typealias Cell = HeadlinesCell
    
    func getHeadlinesCount() -> Int {
        headlines.count
    }
    
    func configure(cell: Cell, index: Int) {
        cell.delegate = self
        let model = headlines[index]
        cell.displayTitle(model.title)
        cell.displaySource(model.source)
        cell.displayDate(model.dateString())
        cell.displayDescription(model.desc)
    }
    
    func didSelectHeadline(at index: Int) {
        // TODO: Update the model
        let model = headlines[index]
        guard let url = URL(string: model.url) else { return }
        view?.openUrl(url)
        debugLog("index: \(index)")
    }
    
    func willDisplayHeadline(cell: Cell, index: Int){
        cell.displayImage(urlString: headlines[index].imageUrlString)
    }
}

extension HeadlinesPresenter: HeadlineTableViewCellDelegate{
    func cell(urlString: String , updatesFavoriteState isFavorite: Bool) {
        let model = headlines.first{ $0.url == urlString }
        // TODO: save it
        debugLog(model?.title ?? "")
    }
}

