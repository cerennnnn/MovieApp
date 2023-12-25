//
//  NetworkManager.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 14.12.2023.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData<T: Codable>(forEndpoint endpoint: String, responseType: T.Type, query: String? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        let baseURL = "https://api.themoviedb.org/3/movie/"
        let apiKey = "YOUR_API_KEY"
        
        var urlString = "\(baseURL)\(endpoint)?api_key=\(apiKey)"
        if let query = query, let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            urlString += "&query=\(encodedQuery)"
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    print("No data received.")
                    completion(.failure(NetworkError.noData))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                    print("url: \(urlString)")
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                    completion(.failure(NetworkError.decodingError))
                }
            }.resume()

        } else {
            completion(.failure(NetworkError.invalidURL))
        }
    }

}
