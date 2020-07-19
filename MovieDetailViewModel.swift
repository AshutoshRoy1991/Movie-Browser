//
//  MovieDetailViewModel.swift
//  Movie Browser
//
//  Created by Ashutosh Roy on 18/07/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    
    private var movieClient = MovieClient()
    
    var id: Int!
    var title: String!
    //    var genre: String?
    var releaseDate: String?
    var overview: String?
    var voteAverage: Double?
    var posterPath: String?
    //    var posterURL: URL?
    var backdropPath: String?
    var backdropURL: URL?
    
    init(_ movie: MovieResult) {
        setupMovie(movie)
    }
    
    private func setupMovie(_ movie: MovieResult) {
        self.id = movie.id
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
        self.voteAverage = movie.voteAverage
        self.posterPath = movie.posterPath
        self.backdropPath = movie.backdropPath
    }
    
    
    func getMovieDetail() {
        
        movieClient.getMovieDetail(with: self.id) { result in
            switch result {
            case .success(let movie):
                print(movie)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
