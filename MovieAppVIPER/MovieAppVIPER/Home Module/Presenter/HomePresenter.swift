//
//  HomePresenter.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 15.12.2023.
//

import Foundation

final class HomePresenter: ViewToPresenterHomeProtocol {
    var homeInteractorObject: PresenterToInteractorHomeProtocol?
    var homeViewObject: PresenterToViewHomeProtocol?
    
    func getNowPlayingMovies() {
        homeInteractorObject?.getAllNowPlayingMovies()
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    func sendDataToPresenter(movies: [NowPlaying]) {
        homeViewObject?.sendDataToView(movies: movies)
    }
}
