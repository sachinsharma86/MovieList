//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Sachin on 1/2/19.
//

import Foundation

struct MovieViewModel {
    
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let genre: String?
    
    init?(model: Movie, genres:[Genre]) {
        
        self.id = model.id
        self.title = model.title
        self.overview = model.overview
        self.posterPath = model.posterPath
        
        let dateString = Date.userFriendlyDateString(dateString: model.releaseDate)
        self.releaseDate = "Release Date: \(dateString)"
        
        guard let firstGenre = model.genre.first else {
            return nil
        }
        
        let genreName = genres.compactMap{ genre -> String? in
            if (genre.id == firstGenre) {
                return genre.name
            }
            return nil
        }
        
        self.genre = genreName.first
    }
}
