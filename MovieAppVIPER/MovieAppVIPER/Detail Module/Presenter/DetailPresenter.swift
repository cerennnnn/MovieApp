//
//  DetailPresenter.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 16.12.2023.
//

import Foundation

final class DetailPresenter: ViewToPresenterDetailProtocol {
    var detailInteractor: PresenterToInteractorDetailProtocol?
    var detailViewObject: PresenterToViewDetailProtocol?
    
    func getDetailMovie(with id: Int) {
        detailInteractor?.getDetailMovie(with: id)
    }
}

extension DetailPresenter: InteractorToPresenterDetailProtocol {
    func sendDetailMovieToPresenter(movie: NowPlaying) {
        detailViewObject?.sendDetailMovieToView(movie: movie)
    }
}
