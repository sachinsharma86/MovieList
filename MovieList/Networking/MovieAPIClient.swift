//
//  MovieAPIClient.swift
//  MovieList
//
//  Created by Sachin on 12/17/18.
//

import Foundation

class MovieAPIClient {
    
    private enum MovieAPI {
        
        //To make sure no other class can read, private api key is secure within this class
        static let key = "65e626a1e0d681a0f9c45dfe75a8cabc"
        static let baseUrlString = "https://api.themoviedb.org/3/movie/"
        static let posterBaseUrl = "https://image.tmdb.org/t/p/w342/"
    }
    
    struct requestType {
        static let get = "GET"
    }
    
    typealias MoviesCompletionHandler = ([Movie]?, Int?, MovieError?) -> Void
    typealias MovieDetailCompletionHandler = (MovieDetail?, MovieError?) -> Void
    typealias GenreCompletionHandler = ([Genre]?, MovieError?) -> Void
    typealias GetDataCompletionHandler = (Data?,MovieError?) -> Void
    
    private let session = {
        URLSession.init(configuration: .default)
    }()
    
    ///Get top rated movies
    
    func getTopRated(page: Int, completionHandler completion:@escaping MoviesCompletionHandler){
        
        guard let url = URL(string: "\(MovieAPI.baseUrlString)top_rated?page=\(page)&language=en-US&api_key=\(MovieAPI.key)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = requestType.get
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(nil, nil, .requestFailed)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let movies = try decoder.decode(MovieList.self, from: data)
                completion(movies.results, movies.totalPages, nil)
                
            } catch {
                completion(nil, nil, .jsonParsingFailure)
            }
        }
        
        task.resume()
    }
    
    ///Get movie details by passing the movie ID
    
    func getMovieDetail(movieId: Int, completionHandler completion:@escaping MovieDetailCompletionHandler){
        var request = URLRequest(url: URL(string: "\(MovieAPI.baseUrlString)\(movieId)?language=en-US&api_key=\(MovieAPI.key)")!)
        request.httpMethod = requestType.get
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                completion(nil, .requestFailed)
                return
            }
            let decoder = JSONDecoder()
            do {
                let movieDetail = try decoder.decode(MovieDetail.self, from: data)
                completion(movieDetail, nil)
                
            } catch {
                completion(nil, .jsonParsingFailure)
            }
        }
        task.resume()
    }
    
    ///Get the genre details
    
    func getGenre(completionHandler completion:@escaping GenreCompletionHandler){
        
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=\(MovieAPI.key)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = requestType.get
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(nil, .requestFailed)
                return
            }
            let decoder = JSONDecoder()
            do {
                let genres = try decoder.decode(Genres.self, from: data)
                completion(genres.genres, nil)
                
            } catch {
                completion(nil, .jsonParsingFailure)
            }
        }
        
        task.resume()
        
    }
    
    ///Download the data asynchronously
    
    func getPosterImageFrom(path: String, completionHandler completion: @escaping GetDataCompletionHandler ) {
        
        if let url = URL(string: MovieAPI.posterBaseUrl + path) {
            
            let getDataTask = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, .requestFailed)
                    return
                }
                if httpResponse.statusCode == 200 {
                    if let data = data{
                        completion(data, nil)
                    } else {
                        completion(nil, .invalidData)
                    }
                } else {
                    completion(nil, .requestUnsucessful)
                }
            }
            getDataTask.resume()
        }
    }
    
}
