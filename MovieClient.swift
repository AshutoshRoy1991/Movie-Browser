//
//  MovieClient.swift
//  Movie Browser
//
//  Created by Ashutosh Roy on 19/07/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import Foundation

class MovieClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    // MARK: - Movie list
    
    func getMovies(page: Int, filter: MovieListFilter, completion: @escaping (Result<MovieListModel?, APIError>) -> Void) {
        let request = getMovieListRequest(with: filter, page: page)
        fetch(with: request, decode: { json -> MovieListModel? in
            guard let movieResult = json as? MovieListModel else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    private func getMovieListRequest(with filter: MovieListFilter, page: Int) -> URLRequest {
        switch filter {
        case .popular:
            return MovieEndPoint.getpopular(page: page).request
        case .topRated:
            return MovieEndPoint.getTopRated(page: page).request
        }
    }
    
    // MARK: - Movie search
    
    func searchMovies(searchText: String, completion: @escaping (Result<MovieListModel?, APIError>) -> Void) {
        fetch(with: MovieEndPoint.searchMovie(searchText: searchText).request, decode: { json -> MovieListModel? in
            guard let movieResult = json as? MovieListModel else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    // MARK: - Movie detail
    
    func getMovieDetail(with movieId: Int, completion: @escaping (Result<MovieResult, APIError>) -> Void) {
        fetch(with: MovieEndPoint.getDetail(id: movieId).request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
}
