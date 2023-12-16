//
//  DetailViewController.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 14.12.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var detailPresenterObject: DetailPresenter?
    var movie: NowPlaying?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureUI()
        DetailRouter.executeModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let movieID = movie?.id {
            detailPresenterObject?.getDetailMovie(with: movieID)
        }
    }
    
    init(movie: NowPlaying) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //MARK: - Top View
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let detailMovieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "placeholderImage")
        imageView.clipsToBounds = true
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return imageView
    }()
    
    let detailMovieOverviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    let detailMovieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    //MARK: - Middle View
    private let middleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private func configureUI() {
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        configureTopView()
        configureMiddleView()
    }
    
    private func configureTopView() {
        topView.addSubview(detailMovieImageView)
        topView.addSubview(detailMovieTitleLabel)
        contentView.addSubview(topView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -8),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            topView.heightAnchor.constraint(equalToConstant: 500),
            
            detailMovieImageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 8),
            detailMovieImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            detailMovieImageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            detailMovieImageView.heightAnchor.constraint(equalToConstant: 400),
            
            detailMovieTitleLabel.topAnchor.constraint(equalTo: detailMovieImageView.bottomAnchor, constant: 8),
            detailMovieTitleLabel.leadingAnchor.constraint(equalTo: detailMovieImageView.leadingAnchor),
            detailMovieTitleLabel.trailingAnchor.constraint(equalTo: detailMovieImageView.trailingAnchor),
            detailMovieTitleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor)
        ])
    }
    
    func configureMiddleView() {
        contentView.addSubview(detailMovieOverviewLabel)
        
        NSLayoutConstraint.activate([
            detailMovieOverviewLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 48),
            detailMovieOverviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            detailMovieOverviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            detailMovieOverviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

extension DetailViewController: PresenterToViewDetailProtocol {
    func sendDetailMovieToView(movie: NowPlaying) {
        DispatchQueue.main.async { [weak self] in
            if let url = URL(string: "https://image.tmdb.org/t/p/w500" + movie.poster_path!) {
                self?.detailMovieImageView.kf.setImage(with: url)
            } else {
                self?.detailMovieImageView.image = UIImage(named: "placeholderImage")
            }
            self?.detailMovieTitleLabel.text = movie.title
            self?.detailMovieOverviewLabel.text = movie.overview
            self?.movie = movie
            self?.detailPresenterObject?.sendDetailMovieToPresenter(movie: movie)
        }
    }
}
