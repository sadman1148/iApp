//
//  Constants.swift
//  iMovie
//
//  Created by Sadman on 7/5/25.
//

import Foundation

enum Constants {
    
    enum API {
        static let baseUrl = "https://api.themoviedb.org/3"
        static let apiKey = "c33832f707ec95387239c7014b8fb76b"
        static let imageSizedBaseUrl = "https://image.tmdb.org/t/p/w500"
        static let imageOriginalBaseUrl = "https://image.tmdb.org/t/p/original"
        static let searchEndpoint = "/search/multi?api_key=\(apiKey)&include_adult=true&query="
    }
    
}
