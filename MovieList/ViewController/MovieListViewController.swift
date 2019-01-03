//
// MovieListViewController.swift
//  MovieList
//
//  Created by Sachin on 12/17/18.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let apiClient = MovieAPIClient()
    private var movies = [MovieViewModel]()
    
    private let loadingCellTag = 111
    private let cellHeight = 110.0
    private var detailViewController: MovieDetailViewController? = nil
    private var genres = [Genre]()
    private var currentPage = 1
    private var totalPages = 1
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Top Rated"
        getGenreData()
    }
    
    // MARK: - Data
    
    private func getGenreData() {
        
        apiClient.getGenre { [weak self] (genres, error) in
            guard let genres = genres else {
                return
            }
            self?.genres = genres
            self?.getTopRatedMovies()
        }
    }
    
    private func getTopRatedMovies(){
        
        apiClient.getTopRated(page: currentPage) { [weak self] (movies, totalPages, error)  in
            
            guard let movies = movies,
                let totalPages = totalPages,
                let genres = self?.genres else {
                    return
            }
            
            let viewModels = movies.compactMap({ movie in
                return MovieViewModel(model: movie, genres: genres)
            })
            
            for model in viewModels {
                self?.movies.append(model)
            }
            
            self?.totalPages = totalPages
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
            segue.identifier == "showDetail",
            let controller = (segue.destination as? UITableViewController) as? MovieDetailViewController else {
                return
        }
        let object = movies[indexPath.row]
        controller.detailItem = object
    }
    
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Cells
    
    private func movieCellForIndexpath(indexPath: IndexPath) -> MovieTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCell", for: indexPath) as! MovieTableViewCell
        
        let movie = movies[indexPath.row]
        cell.genre.text = movie.genre
        cell.movieTitle.text = movie.title
        cell.movieDescription.text = movie.overview
        cell.date.text = movie.releaseDate
        let posterPath = movie.posterPath
        apiClient.getPosterImageFrom(path: posterPath) { (data, error) in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                cell.movieImageView.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    // Loading more cell
    private func loadingCell() -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "Loading"
        cell.tag = loadingCellTag
        return cell
    }
    
    //MARK: - Delegates and Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentPage == 0 {
            return 1
        }
        if movies.count > 0 {
            if currentPage <= totalPages {
                return movies.count + 1
            }
        }
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < movies.count {
            return self.movieCellForIndexpath(indexPath: indexPath)
        } else {
            return self.loadingCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.tag == loadingCellTag {
            currentPage += 1
            self.getTopRatedMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
