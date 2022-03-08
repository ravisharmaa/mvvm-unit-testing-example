//
//  MovieViewModel.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 3/6/22.
//

import Foundation

protocol MovieViewModelResultPresentable: AnyObject {
    func presentResult(_ result: Result<[MovieResult], Error>?)
    func setupViewState(_ with: MovieViewState)
}

protocol URLManagerProtocol {
    func prepareURL(withString: String) -> URL?
}

class URlManager: URLManagerProtocol {

    func prepareURL(withString: String) -> URL? {
        return URL(string: withString)
    }

}

class MovieViewModel {

    let service: NetworkingProtocol
    let urlManager: URLManagerProtocol

    weak var resultPresentable: MovieViewModelResultPresentable?

    init(_ service: NetworkingProtocol, urlManager: URLManagerProtocol) {
        self.service = service
        self.urlManager = urlManager

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

    func getDataFromApi() {
        guard let url = urlManager.prepareURL(withString: "https://google.com") else {
            self.viewStateFor(for: NetworkError.invalidURL)
            return
        }

        self.service.loadUsingModel([MovieResult].self, from: .init(url: url)) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                self.viewStateFor(for: error)
            }

        }
    }

    internal func viewStateFor(for error: Error) {
        guard let error = error as? NetworkError else {
            self.resultPresentable?.setupViewState(.error(.init(errorText: "Unknown error", isLoading: true)))
            return
        }

        self.resultPresentable?.setupViewState(.error(.init(errorText: error.description, isLoading: false)))
    }

    internal func viewStateFor(for: [MovieResult]) {

    }
}
