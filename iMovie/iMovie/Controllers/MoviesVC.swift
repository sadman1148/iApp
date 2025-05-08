//
//  MoviesVC.swift
//  iMovie
//
//  Created by Sadman on 5/5/25.
//

import UIKit

enum Sections: Int {
    case trending = 0
    case popular = 1
    case topRated = 2
    case upcoming = 3
}

class MoviesVC: UIViewController {

    let sectionTitles: [String] = ["Trending", "Popular", "Top Rated", "Upcoming"]
    
    let moviesTableView: UITableView = {
        return UITableView(frame: .zero, style: .grouped)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        moviesTableView.register(
            MovieCollectionTableViewCell.self,forCellReuseIdentifier:MovieCollectionTableViewCell.identifier
        )
        view.addSubview(moviesTableView)
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.separatorColor = UIColor.clear
        
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        moviesTableView.tableHeaderView = headerView
        
        configureNavbar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        moviesTableView.frame = view.bounds
    }
    
    private func configureNavbar() {
        navigationItem.title = "Movies"
        let container = UIControl(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        let imageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        imageView.image = UIImage(named: "tmdb")?.withRenderingMode(.alwaysOriginal)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        container.addSubview(imageView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: container)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let defaultOffset = view.safeAreaInsets.top
//        let offset = scrollView.contentOffset.y + defaultOffset
//        
//        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
//    }
    
}

extension MoviesVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(
            withIdentifier: MovieCollectionTableViewCell.identifier, for: indexPath
        ) as? MovieCollectionTableViewCell else {
            return UITableViewCell()
        }
        
        let completion: (Result<[Media], Error>) -> Void = { result in
            switch result {
            case .success(let movies):
                cell.feedCollectionView(with: movies)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
        switch indexPath.section {
            case Sections.trending.rawValue: ApiService.shared.getTrendingMovies(complete: completion)
            case Sections.popular.rawValue: ApiService.shared.getPopularMovies(complete: completion)
            case Sections.topRated.rawValue: ApiService.shared.getTopRatedMovies(complete: completion)
            case Sections.upcoming.rawValue: ApiService.shared.getUpcomingMovies(complete: completion)
            default: return UITableViewCell()
        }
        
        return cell
    }
}
