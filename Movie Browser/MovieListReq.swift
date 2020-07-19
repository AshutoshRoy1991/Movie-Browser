////
////  MovieListReq.swift
////  Movie Browser
////
////  Created by Ashutosh Roy on 16/07/20.
////  Copyright © 2020 Ashutosh Roy. All rights reserved.
////
//
//import Foundation
//
//final class MovieListReq: APIConfiguration {
//
//    typealias ResponseType = MovieListModel
//    
//    private var pageNumber :String
//    
//    init(pageNumber:String) {
//        self.pageNumber = pageNumber
//    }
//    
//    var baseUrl: URL {
//        return URL(string: "https://api.themoviedb.org/")!
//    }
//    
//    var endpoint: String {
//        return "3/movie/popular"
//    }
//    
//    var method: NetworkAccess.Method {
//        return .get
//    }
//    
//    var query: NetworkAccess.QueryType {
//        return .path
//    }
//    
//    var parameters: [String : Any]? {
//        return ["api_key" : "2cf28df74f7463ce7ef6ffd4dca51713","language":"en-US","page":self.pageNumber]
//    }
//    
//    var headers: [String : String]? {
//        return defaultJSONHeader
//    }
//    
//    var timeout: TimeInterval {
//        return 30.0
//    }
//    
//    var cachePolicy: NSURLRequest.CachePolicy {
//        return .reloadIgnoringLocalAndRemoteCacheData
//    }
//}
