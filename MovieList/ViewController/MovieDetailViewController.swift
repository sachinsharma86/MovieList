//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Sachin on 12/17/18.
//

import UIKit

class MovieDetailViewController: UITableViewController {
    
    var apiClient = MovieAPIClient()
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var productionCompanyLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    var detailItem: MovieViewModel? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    private func configureView() {
        // Update the user interface for the detail view.
        guard let detail = detailItem else {
            return
        }
        apiClient.getMovieDetail(movieId: detail.id) { [weak self](movieDetail, error) in
            guard let movieDetail = movieDetail,
                let viewModel = MovieDetailViewModel(model: movieDetail) else {
                    return
            }
            DispatchQueue.main.async {
                self?.title = viewModel.title
                self?.movieDescriptionLabel.text = viewModel.description
                self?.releaseDateLabel.text = viewModel.releaseDate
                self?.budgetLabel.text = viewModel.budget
                self?.showPosterImage(withPosterPath: viewModel.posterPath)
                self?.genreLabel.text = viewModel.genre
                self?.productionCompanyLabel.text = viewModel.productionCompany
            }
        }
    }
    
    private func showPosterImage(withPosterPath: String) {
        apiClient.getPosterImageFrom(path: withPosterPath) { (data, error) in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self.movieImageView.image = UIImage(data: data)
            }
        }
    }
    
}

extension MovieDetailViewController {
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
