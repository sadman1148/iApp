//
//  SearchVC.swift
//  iMovie
//
//  Created by Sadman on 5/5/25.
//

import UIKit

class SearchVC: UIViewController {

    private var mediaList: [Media] = []
    
    private let searchBar: UISearchBar = {
        let searcher = UISearchBar()
        searcher.placeholder = "Search movies & TV shows..."
        searcher.translatesAutoresizingMaskIntoConstraints = false
        return searcher
    }()
    
    private let searchResultTable: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        view.addSubview(searchResultTable)
        searchResultTable.delegate = self
        searchResultTable.dataSource = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            searchResultTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            searchResultTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultTable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
//    private func search() {
//        ApiService.shared.getSearchResults(for: "", complete: { [weak self] result in
//            switch result {
//            case .success(let movies):
//                cell.feedCollectionView(with: movies)
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//    }

}

extension SearchVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell
        else {
            return UITableViewCell()
        }
        let media = mediaList[indexPath.row]
        cell.configureCell(with: TitleViewModel(title: media.title, posterUrl: media.posterPath ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
