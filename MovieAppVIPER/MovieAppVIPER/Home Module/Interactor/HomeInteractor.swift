//
//  HomeInteractor.swift
//  MovieAppVIPER
//
//  Created by Ceren Güneş on 15.12.2023.
//

import Foundation

final class HomeInteractor: PresenterToInteractorHomeProtocol {
    var homePresenterObject: InteractorToPresenterHomeProtocol?
    
    func getAllNowPlayingMovies() {
        NetworkManager.shared.fetchData(forEndpoint: "now_playing", responseType: NowPlayingMovies.self, query: nil) { result in
            switch result {
            case .success(let success):
                if let nowPlayingArr = success.results {
                    self.homePresenterObject?.sendDataToPresenter(movies: nowPlayingArr)
                } else {
                    print("Hata: success.results boş.")
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
