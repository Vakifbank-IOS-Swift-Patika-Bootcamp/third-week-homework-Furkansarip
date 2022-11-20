//
//  NetworkManager.swift
//  RandomQuotesApp
//
//  Created by Furkan Sarı on 20.11.2022.
//

import Foundation

enum QuotesError : String,Error{
    case invalidURL = "Bad URL"
    case unableToComplete = "Check your internet connection"
    case invalidResponse = "Invalid Response"
    case invalidData = "The data received from the server was invalid. Please try again!"
    case alreadyInFavorites = "User already in Favorites List"
    
}

struct NetworkManager {
    private let endpoint = "https://programming-quotes-api.herokuapp.com/Quotes/random"
    
    static let shared = NetworkManager()
    private init(){}
    
    func getQuotes(completion:@escaping(_ result:Result<QuotesModel,QuotesError>)->Void){
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                print("hello")
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let quotes = try decoder.decode(QuotesModel.self, from: data)
                completion(.success(quotes))
            }catch{
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
}

