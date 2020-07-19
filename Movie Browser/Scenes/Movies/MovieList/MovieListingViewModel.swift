//
//  MovieListingViewModel.swift
//  Movie Browser
//
//  Created by Ashutosh Roy on 18/07/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import Foundation

enum MovieListFilter {
    case popular, topRated
    
    var title: String? {
        switch self {
        case .popular:
            return "Popular Movies"
        case .topRated:
            return "Top Rated Movies"
        }
    }
}

class MovieListingViewModel {
    
    private var movieClient = MovieClient()
    
    var moviesData :[MovieResult] = []
    
    func fetchMovies(currentPage: Int, filter: MovieListFilter, showLoader: Bool = false, completion: (() -> Void)?) {
        movieClient.getMovies(page: currentPage, filter: filter, completion: {[weak self] result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                self?.moviesData = movieResult.results
                completion?()
            case .failure(let error):
                print(error)
            }
        })
    }
    
}
