//
//  Genres.swift
//  MovieList
//
//  Created by Sachin on 1/2/19.
//

import Foundation

struct Genre: Codable {
    let id: Int?
    let name: String?
}

struct Genres: Codable {
    let genres: [Genre]
}
