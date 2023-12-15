//
//  HomeRouter.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 15.12.2023.
//

import Foundation

final class HomeRouter: PresenterToRouterHomeProtocol {
    static func executeModule(ref: HomeViewController) {
        let presenter = HomePresenter()
        
        ref.homePresenterObject = presenter
        
        //Presenter
        ref.homePresenterObject?.homeInteractorObject = HomeInteractor()
        ref.homePresenterObject?.homeViewObject = ref 
        
        //Interactor
        ref.homePresenterObject?.homeInteractorObject?.homePresenterObject = presenter
    }
}
