//
//  MovieTableViewCell.swift
//  MovieList
//
//  Created by Sachin on 12/17/18.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
