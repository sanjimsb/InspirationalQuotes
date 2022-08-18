//
//  Quotes_Helpler.swift
//  InspiringQuotes
//
//  Created by Bipin Msb on 2022-07-24.
//

import Foundation
import UIKit

class Get_Quotes {
    private static let baseUrl = "https://api.quotable.io/quotes"
    private static let endpointQuoteList = URL(string: "https://api.quotable.io/quotes?limit=100")!
    private static let endpointAuthors = URL(string: "https://api.quotable.io/authors?limit=100")!
    // other tags will also be used
    private static let endpointTagSpecific = URL(string: "https://api.quotable.io/random?tags=technology")
    
    private static let session: URLSession = {
        var config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
  
    
    static func fetchQuoteList() async throws -> [QuotesData] {
        let request = URLRequest(url: endpointQuoteList)
        let (data, _) = try await session.data(for: request)
        
        let decoder = JSONDecoder()
        let quotesData = try decoder.decode(QuotesModel.self, from: data)
    
        return quotesData.results
    }
    
    static func fetchQuoteByAuthor(getAuthor: String) async throws -> [QuotesData] {
        let request = URLRequest(url: URL(string: baseUrl + "?author=" + getAuthor + "&limit=100")!)
        let (data, _) = try await session.data(for: request)
        
        let decoder = JSONDecoder()
        let quotesData = try decoder.decode(QuotesModel.self, from: data)
    
        return quotesData.results
    }
    
    static func fetchAuthors() async throws -> [Authors] {
        let request = URLRequest(url: endpointAuthors)
        let (data, _) = try await session.data(for: request)
        
        let decoder = JSONDecoder()
        let authors = try decoder.decode(AuthorsList.self, from: data)
    
        return authors.results
    }
    
//    static func fetchQuoteList(callback: @escaping (Any) -> Void){
//        let request = URLRequest(url: endpointQuoteList!)
//        let task = session.dataTask(with: request) {
//         data, response, error in
//            if let data = data {
//                do{
//                    let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
//                    callback(jsonData)
//                }catch let error{
//                    print("Error \(error)")
//                }
//            } else if let error = error {
//                print(error)
//            } else {
//                print("Unknown Error")
//            }
//        }
//        task.resume()
//    }
    
//    static func fetchAuthors(callback: @escaping (Any) -> Void){
//        let request = URLRequest(url: endpointAuthors!)
//        let task = session.dataTask(with: request) {
//         data, response, error in
//            if let data = data {
//                do{
//                    let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
//                    callback(jsonData)
//                }catch let error{
//                    print("Error \(error)")
//                }
//            } else if let error = error {
//                print(error)
//            } else {
//                print("Unknown Error")
//            }
//        }
//        task.resume()
//    }
//
//
//    static func fetchTagSpecificQuotes(callback: @escaping (Any) -> Void){
//        let request = URLRequest(url: endpointTagSpecific!)
//        let task = session.dataTask(with: request) {
//         data, response, error in
//            if let data = data {
//                do{
//                    let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
//                    callback(jsonData)
//                }catch let error{
//                    print("Error \(error)")
//                }
//            } else if let error = error {
//                print(error)
//            } else {
//                print("Unknown Error")
//            }
//        }
//        task.resume()
//    }

}
