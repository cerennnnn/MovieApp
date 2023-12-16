//
//  Protocols.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 16.12.2023.
//

import Foundation

protocol ViewToPresenterDetailProtocol {
    var detailInteractor: PresenterToInteractorDetailProtocol? { get set }
    var detailViewObject: PresenterToViewDetailProtocol? { get set }
    
    func getDetailMovie(with id: Int)
}

protocol PresenterToInteractorDetailProtocol {
    var detailPresenterObject: InteractorToPresenterDetailProtocol? { get set }
    
    func getDetailMovie(with id: Int)
}

protocol InteractorToPresenterDetailProtocol {
    func sendDetailMovieToPresenter(movie: NowPlaying)
}

protocol PresenterToViewDetailProtocol {
    func sendDetailMovieToView(movie: NowPlaying)
}

protocol PresenterToRouterDetailProtocol {
    static func executeModule(ref: DetailViewController)
}
