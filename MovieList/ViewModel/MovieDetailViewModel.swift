//
//  MovieDetailViewModel.swift
//  MovieList
//
//  Created by Sachin on 1/2/19.
//

import Foundation

struct MovieDetailViewModel {
    
    let title : String
    let description: String
    let releaseDate: String
    let genre: String
    let budget: String
    let posterPath: String
    let productionCompany: String
    
    init?(model:MovieDetail) {
        
        self.title = model.title
        self.description = "Description: \n\(model.description)"
        self.posterPath = model.posterPath
        
        let dateString = Date.userFriendlyDateString(dateString: model.releaseDate)
        self.releaseDate = "Release Date: \(dateString)"
        
        let budgetInMillion = Double(model.budget/1000000)
        self.budget = "Budget: $\(budgetInMillion) million"
        
        var genre = [String]()
        for item in model.genre {
            guard let name = item.name else {
                return nil
            }
            genre.append(name)
        }
        self.genre = "Genre: \(genre.joined(separator: ", "))"
        
        var productionCompany = [String]()
        for item in model.productionCompanies {
            guard let name = item.name else {
                return nil
            }
            productionCompany.append(name)
        }
        self.productionCompany = "Production Company: \(productionCompany.joined(separator: ", "))"
    }
}
