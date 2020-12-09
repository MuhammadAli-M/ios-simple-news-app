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
    
    func getHeadlines(countryCode: CountryCode, categories: [CategoryName], completionHandler: @escaping ( ([Article], Error?) -> Void)){
        let urlString = baseUrl + endpoint + "?" + "country=\(countryCode)" + "apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{
                errorLog("requesting \(url.absoluteString) , error : \(error?.localizedDescription ?? " ")")
                completionHandler([],error)
                return
            }
            
            do{
                let List = try newJSONDecoder().decode(TopHeadlinesData.self, from: data)
                completionHandler(List.articles ?? [],nil)
                debugLog("List is recieved")
            }catch{
                completionHandler([],error)
                errorLog("while json parsing, error : \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}




//   let topHeadlinesData = try? newJSONDecoder().decode(TopHeadlinesData.self, from: jsonData)


// MARK: - TopHeadlinesData
struct TopHeadlinesData: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}


// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
