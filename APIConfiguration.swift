//
//  APIConfiguration.swift
//  Movie Browser
//
//  Created by Ashutosh Roy on 18/07/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import Foundation

public protocol APIConfiguration {
    
    associatedtype ResponseType: Codable
    
    var endpoint: String { get }
    var method: Method { get }
    var query:  QueryType { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var baseUrl: URL { get }
    
    var timeout : TimeInterval { get }
    var cachePolicy : NSURLRequest.CachePolicy { get }
}

public extension APIConfiguration {
    
    var defaultJSONHeader : [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    var request: URLRequest {
        
        var request : URLRequest? = nil
        
        let url = baseUrl.appendingPathComponent(endpoint)
        
        switch query {
        case .json:
            request = URLRequest(url: url, cachePolicy: cachePolicy,
                                 timeoutInterval: timeout)
            if let params = parameters {
                do {
                    let body = try JSONSerialization.data(withJSONObject: params, options: [])
                    request!.httpBody = body
                } catch {
                    assertionFailure("Error : while attemping to serialize the data for preparing httpBody \(error)")
                }
            }
        case .path:
            var query = ""
            
            parameters?.forEach { key, value in
                query = query + "\(key)=\(value)&"
            }
            
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.query = query
            request = URLRequest(url: components.url!, cachePolicy: cachePolicy, timeoutInterval: timeout)
        }
        
        request!.allHTTPHeaderFields = headers
        request!.httpMethod = method.rawValue
        
        return request!
    }
}
public enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum QueryType {
    case json, path
}
