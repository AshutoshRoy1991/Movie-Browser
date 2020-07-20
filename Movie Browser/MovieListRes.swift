//
//  MovieListRes.swift
//  Movie Browser
//
//  Created by Ashutosh Roy on 16/07/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import Foundation

// MARK: - MovieListModel
public struct MovieListModel: Codable {
    let page, totalResults, totalPages: Int
    public let results: [MovieResult]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
public struct MovieResult: Codable {
    public let popularity: Double
    public let voteCount: Int
    public let video: Bool
    public let posterPath: String?
    public let id: Int
    public let adult: Bool
    public let backdropPath: String?
    public let originalLanguage, originalTitle: String
    public let genreIDS: [Int]
    public let title: String
    public let voteAverage: Double
    public let overview, releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
