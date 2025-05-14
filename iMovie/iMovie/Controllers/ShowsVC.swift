//
//  ShowsVC.swift
//  iMovie
//
//  Created by Sadman on 5/5/25.
//

import UIKit

class ShowsVC: UIViewController {

    enum Sections: Int {
        case trending = 0
        case popular = 1
        case topRated = 2
    }
    
    let sectionTitles: [String] = ["Trending", "Popular", "Top Rated"]
    
    let showsTableView: UITableView = {
        return UITableView(frame: .zero, style: .grouped)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        showsTableView.register(
            MediaCollectionTableViewCell.self,forCellReuseIdentifier:MediaCollectionTableViewCell.identifier
        )
        view.addSubview(showsTableView)
        showsTableView.delegate = self
        showsTableView.dataSource = self
        showsTableView.separatorColor = UIColor.clear
        
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        showsTableView.tableHeaderView = headerView
        
//        configureNavbar()
    }

}

extension ShowsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
