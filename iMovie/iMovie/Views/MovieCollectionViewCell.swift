//
//  MovieCollectionTableViewCell.swift
//  iMovie
//
//  Created by Sadman on 6/5/25.
//

import UIKit

class MovieCollectionTableViewCell: UITableViewCell {
    
    static let identifier = "MovieCollectionTVC"
    
    var media: [Media] = [Media]()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MediaCVCell.self, forCellWithReuseIdentifier: MediaCVCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func feedCollectionView(with media: [Media]) {
        self.media = media
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

extension MovieCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return media.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(
            withReuseIdentifier: MediaCVCell.identifier, for: indexPath
        ) as? MediaCVCell else {
            return UICollectionViewCell()
        }
        guard let url = media[indexPath.row].posterPath else { return UICollectionViewCell() }
        cell.setupPoster(with: url)
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        return cell
    }
}
