//
//  HomeTableViewCell.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 15.12.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    public var reviewCount: Int = 0 {
        didSet {
            updateStars()
        }
    }
    
    static let identifier = "HomeTableViewCell"
    
    public let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    public let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    public let movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 13, weight: .regular)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieOverviewLabel)
        contentView.addSubview(starStackView)
        
        applyConstraints()
        setupStars()
    }
    
    private func setupStars() {
        for _ in 0..<5 {
            let starImageView = UIImageView()
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.contentMode = .scaleAspectFit
            starImageView.image = UIImage(systemName: "star.fill")
            starStackView.addArrangedSubview(starImageView)
            starImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        }
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            movieImageView.widthAnchor.constraint(equalToConstant: 120),
            
            movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 8),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            
            starStackView.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            starStackView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 8),
            starStackView.bottomAnchor.constraint(equalTo: movieOverviewLabel.topAnchor, constant: -8),
            
            movieOverviewLabel.topAnchor.constraint(equalTo: starStackView.bottomAnchor, constant: 8),
            movieOverviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            movieOverviewLabel.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            movieOverviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func updateStars() {
        let starCount = calculateStarCount()
        
        for (index, arrangedSubview) in starStackView.arrangedSubviews.enumerated() {
            if let starImageView = arrangedSubview as? UIImageView {
                starImageView.image = index < starCount ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
                starImageView.tintColor = .systemYellow
            }
        }
    }
    
    private func calculateStarCount() -> Int {
        if reviewCount < 10 && reviewCount > 8 {
            return 5
        } else if reviewCount < 8 && reviewCount > 6 {
            return 4
        } else if reviewCount < 6 && reviewCount > 4 {
            return 3
        } else if reviewCount < 4 && reviewCount > 2 {
            return 2
        } else {
            return 1
        }
    }
}
