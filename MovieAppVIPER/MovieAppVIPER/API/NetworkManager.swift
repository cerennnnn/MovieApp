//
//  NetworkManager.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 14.12.2023.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData<T: Codable>(forEndpoint endpoint: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        let baseURL = "https://api.themoviedb.org/3/movie/"
        let apiKey = "YOUR_API_KEY"
        
        if let url = URL(string: "\(baseURL)\(endpoint)?api_key=\(apiKey)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            }.resume()
        } else {
            completion(.failure(NetworkError.invalidURL))
        }
    }
}
