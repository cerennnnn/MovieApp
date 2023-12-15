//
//  NetworkError.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 15.12.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
