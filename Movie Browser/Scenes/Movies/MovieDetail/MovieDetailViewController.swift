//
//  MovieDetailViewController.swift
//  Movie Browser
//
//  Created by Ashutosh Roy on 18/07/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var movieTitlelabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var raleaseDate: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var viewModel: MovieDetailViewModel? {
        didSet {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDetails()
        viewModel?.getMovieDetail()
        // Do any additional setup after loading the view.
    }
    
    private func updateDetails() {
        guard let viewModel = viewModel else { return }
        
        self.movieTitlelabel.text = viewModel.title
        self.ratingLabel.text = "\(viewModel.voteAverage ?? 0)/10.0"
        self.raleaseDate.text = viewModel.releaseDate
        
        var posterURL: URL?
        let posterpath = viewModel.backdropPath
        if let backdropImagePath = posterpath {
            posterURL = URL(string: URLConfiguration.mediaPath + backdropImagePath)
            self.backdropImage.kf.setImage(with: posterURL)
        }
        self.synopsisLabel.text = viewModel.overview
    }
    
}
