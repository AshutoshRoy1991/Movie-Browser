//
//  MovieSearchViewModel.swift
//  Movie Browser
//
//  Created by Ashutosh Roy on 19/07/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import Foundation

class MovieSearchViewModel {
    
    private var movieClient = MovieClient()
    
    var moviesData :[MovieResult] = []
    
    func searchMovies(searchText: String, completion: (() -> Void)?) {
        movieClient.searchMovies(searchText: searchText) {[weak self] result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                self?.moviesData = movieResult.results
                completion?()
            case .failure(let error):
                print(error)
            }
        }
    }
}
