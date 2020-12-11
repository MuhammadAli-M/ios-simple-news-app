//
//  HeadlinesService.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/9/20.
//

import Foundation


class HeadlinesService: NewsService{
    
    static let shared = HeadlinesService()
    private let endpoint = "/v2/top-headlines"
    
    // TODO: Make the request safe
    func getHeadlines(countryCode: CountryCode, category: CategoryName, completionHandler: @escaping ( ([Article], Error?) -> Void)){
        
        let headlineUrl = HeadlinesURL(baseUrl: baseUrl + endpoint,
                                       queries: [
                                        HeadlineQuery(key: .country, value: countryCode),
                                        HeadlineQuery(key: .category, value: category),
                                        HeadlineQuery(key: .apiKey, value: apiKey)
                                       ])
        
        
        guard let url = headlineUrl.url else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{
                errorLog("requesting \(url.absoluteString) , error : \(error?.localizedDescription ?? " ")")
                completionHandler([],error)
                return
            }
            
            do{
                let headlinesResponseData = try newJSONDecoder().decode(HeadlinesResponseData.self, from: data)
                completionHandler(headlinesResponseData.articles,nil)
                debugLog("recieved \(headlinesResponseData.articles.count)articles ")
            }catch{
                completionHandler([],error)
                errorLog("while json parsing, error : \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
    


