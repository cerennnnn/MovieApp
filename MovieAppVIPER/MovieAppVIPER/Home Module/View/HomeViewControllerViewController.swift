//
//  ViewController.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 14.12.2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController, PresenterToViewDetailProtocol {
    func sendDetailMovieToView(movie: NowPlaying) {
        
    }
    
    var homePresenterObject: ViewToPresenterHomeProtocol?
    var nowPlayingMovies: [NowPlaying] = []
    
    var detailObject: DetailPresenter?
    
    private let moviesTableView: UITableView = {
        let table = UITableView()
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier )
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpView()
        setUpTableView()
        
        HomeRouter.executeModule(ref: self)
    }
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubview(moviesTableView)
    }
    
    private func setUpNavigationBar() {
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setUpTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        moviesTableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        homePresenterObject?.getNowPlayingMovies()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nowPlayingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        let selectedMovie = nowPlayingMovies[indexPath.row]
        
        cell.movieTitleLabel.text = selectedMovie.original_title
        cell.movieOverviewLabel.text = selectedMovie.overview
        cell.movieImageView.layer.cornerRadius = 8
        cell.reviewCount = Int(selectedMovie.vote_average ?? 0)
        cell.accessoryType = .disclosureIndicator
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500" + selectedMovie.poster_path!) {
            cell.movieImageView.kf.setImage(with: url)
        } else {
            cell.movieImageView.image = UIImage(named: "placeholderImage")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let selectedMovieID = nowPlayingMovies[indexPath.row].id else { return }
        detailObject?.getDetailMovie(with: selectedMovieID)
        
        navigationController?.pushViewController(DetailViewController(movie: nowPlayingMovies[indexPath.row]), animated: true)
    }
}

extension HomeViewController: PresenterToViewHomeProtocol {
    func sendDataToView(movies: [NowPlaying]) {
        DispatchQueue.main.async {
            self.nowPlayingMovies = movies
            self.moviesTableView.reloadData()
        }
    }
}
