//
//  DetailInteractor.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 15.12.2023.
//

import Foundation

final class DetailInteractor: PresenterToInteractorDetailProtocol {
    var detailPresenterObject: InteractorToPresenterDetailProtocol?
    
    func getDetailMovie(with id: Int) {
        NetworkManager.shared.fetchData(forEndpoint: "\(id)", responseType: NowPlaying.self) { result in
            switch result {
            case .success(let success):
                self.detailPresenterObject?.sendDetailMovieToPresenter(movie: success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
