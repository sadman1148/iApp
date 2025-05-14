//
//  ApiService.swift
//  iMovie
//
//  Created by Sadman on 7/5/25.
//

import Foundation

class ApiService {
    
    static let shared = ApiService()
    
    func fetchMedia(from path: String, logLabel: String, complete: @escaping (Result<[Media], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.API.baseUrl)\(path)?api_key=\(Constants.API.apiKey)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingMediaResponse.self, from: data)
                complete(.success(results.results))
            } catch {
                print("\(logLabel) error: \(error.localizedDescription)")
                complete(.failure(error))
            }
        }
        task.resume()
    }
    
    func search(with keyword: String, complete: @escaping (Result<[Media], Error>) -> Void) {
        guard let url = URL(
            string: "\(Constants.API.baseUrl)\(Constants.API.searchEndpoint)\(keyword)"
        ) else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingMediaResponse.self, from: data)
                complete(.success(results.results))
            } catch {
                print("search error: \(error.localizedDescription)")
                complete(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTrendingMovies(complete: @escaping (Result<[Media], Error>) -> Void) {
        fetchMedia(from: "/trending/movie/day", logLabel: "trending movies", complete: complete)
    }
    
    func getUpcomingMovies(complete: @escaping (Result<[Media], Error>) -> Void) {
        fetchMedia(from: "/movie/upcoming", logLabel: "upcoming movies", complete: complete)
    }
    
    func getPopularMovies(complete: @escaping (Result<[Media], Error>) -> Void) {
        fetchMedia(from: "/movie/popular", logLabel: "popular movies", complete: complete)
    }
    
    func getTopRatedMovies(complete: @escaping (Result<[Media], Error>) -> Void) {
        fetchMedia(from: "/movie/top_rated", logLabel: "top rated movies", complete: complete)
    }
    
    func getTrendingShows(complete: @escaping (Result<[Media], Error>) -> Void) {
        fetchMedia(from: "/trending/tv/day", logLabel: "trending shows", complete: complete)
    }
    
    func getSearchResults(for query: String, complete: @escaping (Result<[Media], Error>) -> Void) {
        search(with: query, complete: complete)
    }
    
}
