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
    
    var hasMorePages: Bool = false
    var nextPage: Int = 1
    
    func fetchMovies(currentPage: Int, filter: MovieListFilter, showLoader: Bool = false, completion: (() -> Void)?) {
        if currentPage == 1 {
            moviesData = []
            hasMorePages = false
            nextPage = 1
            
        }
        movieClient.getMovies(page: currentPage, filter: filter, completion: {[weak self] result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
//                self?.moviesData = movieResult.results
                self?.processMovieResult(movieResult)
                completion?()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func processMovieResult(_ movieResult: MovieListModel) {

        let fetchedMovies = movieResult.results
        self.moviesData.append(contentsOf: fetchedMovies)
        self.hasMorePages = movieResult.hasMorePages
        self.nextPage = movieResult.nextPage
        
    }
}
