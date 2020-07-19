//
//  MovieEndPoint.swift
//  Movie Browser
//
//  Created by Ashutosh Roy on 18/07/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import Foundation

public enum MovieEndPoint {
    case getpopular(page: Int)
    case getTopRated(page: Int)
    case getDetail(id: Int)
    case searchMovie(searchText: String)
}

extension MovieEndPoint : APIConfiguration {
    
    public typealias ResponseType = MovieListModel
    
    public var baseUrl: URL {
        return URL(string: "https://api.themoviedb.org")!
    }
    
    public var endpoint: String {
        
        switch self {
        case .getpopular:
            return "/3/movie/popular"
        case .getTopRated:
            return "/3/movie/top_rated"
        case .getDetail(let id):
            return "/3/movie/\(id)"
        case .searchMovie:
            return "/3/search/movie"
        }
    }
    
    public var method: Method {
        return .get
    }
    
    public var query: QueryType {
        return .path
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .getpopular(let page):
            return ["api_key" : "2cf28df74f7463ce7ef6ffd4dca51713","language":"en-US","page":page]
        case .getTopRated(let page):
//            return ["page": page]
            return ["api_key" : "2cf28df74f7463ce7ef6ffd4dca51713","language":"en-US","page":page]
        case .getDetail:
            return ["api_key" : "2cf28df74f7463ce7ef6ffd4dca51713"]
        case .searchMovie(let searchText):
//            return ["query": searchText]
            return ["api_key" : "2cf28df74f7463ce7ef6ffd4dca51713","language":"en-US","query":searchText]
        }
    }
    
    public var headers: [String : String]? {
        return defaultJSONHeader
    }
    
    public var timeout: TimeInterval {
        return 30.0
    }
    
    public var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
    
}
