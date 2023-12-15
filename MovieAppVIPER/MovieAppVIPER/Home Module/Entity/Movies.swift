//
//  Movies.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 15.12.2023.
//

import Foundation

struct NowPlayingMovies: Codable {
    let results: [NowPlaying]?
}

struct NowPlaying: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let id: Int?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}
