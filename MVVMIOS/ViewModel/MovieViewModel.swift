//
//  MovieViewModel.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 3/6/22.
//

import Foundation

protocol MovieViewModelResultPresentable: AnyObject {
    func presentResult(_ result: Result<[MovieResult], Error>?)
}

class MovieViewModel {

    let service: NetworkingProtocol

    weak var resultPresentable: MovieViewModelResultPresentable?

    init(_ service: NetworkingProtocol) {
        self.service = service
    }

    func fetchDataFromApi() {
        guard let url = URL(string: "http://gdhistory.com/api/periods") else {
            self.resultPresentable?.presentResult(.failure(NetworkError.invalidURL))
            return
        }

        service.loadUsingModel([MovieResult].self, from: .init(url: url)) { result in
            switch result {
            case .success(let movieResult):
                self.resultPresentable?.presentResult(.success(movieResult))
            case .failure(let error as NetworkError):
                switch error {
                case .invalidURL:
                    self.resultPresentable?.presentResult(.failure(NetworkError.invalidURL))
                default:
                    self.resultPresentable?.presentResult(.failure(NetworkError.invalidResponse))
                }
            case .failure(let error):
                self.resultPresentable?.presentResult(.failure(error))
            }
        }
    }
}
