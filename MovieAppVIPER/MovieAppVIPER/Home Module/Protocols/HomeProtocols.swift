//
//  Protocols.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 15.12.2023.
//

import UIKit

protocol ViewToPresenterHomeProtocol {
    var homeInteractorObject: PresenterToInteractorHomeProtocol? { get set }
    var homeViewObject: PresenterToViewHomeProtocol? { get set }
    
    func getNowPlayingMovies()
}

protocol PresenterToInteractorHomeProtocol {
    var homePresenterObject: InteractorToPresenterHomeProtocol? { get set }
    
    func getAllNowPlayingMovies()
}

protocol InteractorToPresenterHomeProtocol {
    func sendDataToPresenter(movies: [NowPlaying])
}

protocol PresenterToViewHomeProtocol {
    func sendDataToView(movies: [NowPlaying])
}

protocol PresenterToRouterHomeProtocol {
    static func executeModule(ref: HomeViewController)
}
