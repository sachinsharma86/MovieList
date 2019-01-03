//
//  MovieDetail.swift
//  MovieList
//
//  Created by Sachin on 1/2/19.
//

import Foundation

struct MovieDetail: Codable {
    
    let title: String
    let description: String
    let releaseDate: String
    let genre: [Genre]
    let productionCompanies: [Company]
    let budget: Int
    let posterPath: String
    
    private enum CodingKeys: String, CodingKey, RawRepresentable {
        case title
        case description = "overview"
        case releaseDate = "release_date"
        case genre = "genres"
        case productionCompanies = "production_companies"
        case budget = "budget"
        case posterPath = "poster_path"
    }
}

struct Company: Codable {
    let name: String?
}
