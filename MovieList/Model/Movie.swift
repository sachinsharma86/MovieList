//
//  Movie.swift
//  MovieList
//
//  Created by Sachin on 12/17/18.
//

import Foundation

struct Movie: Codable {
    
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let genre: [Int]
    
    private enum CodingKeys: String, CodingKey, RawRepresentable {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genre = "genre_ids"
    }
}

struct MovieList: Codable {
    
    let totalPages: Int
    let results: [Movie]
    let totalResults: Int
    let page: Int
    
    private enum CodingKeys: String, CodingKey, RawRepresentable {
        case totalPages = "total_pages"
        case results
        case totalResults = "total_results"
        case page
    }
}
