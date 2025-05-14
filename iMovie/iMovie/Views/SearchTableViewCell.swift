//
//  SearchTableViewCell.swift
//  iMovie
//
//  Created by Sadman on 12/5/25.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleImageView)
        applyConstraints()
    }
    
    private func applyConstraints() { 
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleImageView.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    func configureCell(with model: TitleViewModel) {
        guard let url = URL(string: "\(Constants.API.imageSizedBaseUrl)\(model.posterUrl)") else { return }
        titleImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.title
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
