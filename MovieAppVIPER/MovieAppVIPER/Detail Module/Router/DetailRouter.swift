//
//  DetailRouter.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 16.12.2023.
//

import Foundation
final class DetailRouter: PresenterToRouterDetailProtocol {
    static func executeModule(ref: DetailViewController) {
        let detailPresenter = DetailPresenter()
        let detailInteractor = DetailInteractor()
        
        ref.detailPresenterObject = detailPresenter
        detailPresenter.detailInteractor = detailInteractor
        detailPresenter.detailViewObject = ref
        detailInteractor.detailPresenterObject = detailPresenter
    }
}
