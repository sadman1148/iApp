//
//  MediaCVCell.swift
//  iMovie
//
//  Created by BARTA on 8/5/25.
//

import UIKit
import SDWebImage

class MediaCVCell: UICollectionViewCell {
    
    static let identifier = "MediaCVCell"
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func setupPoster(with url: String) {
        guard let url = URL(string: "\(Constants.API.imageBaseUrl)/\(url)") else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
}
