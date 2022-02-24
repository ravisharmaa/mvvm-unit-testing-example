//
//  NewsViewModel.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/13/22.
//

import Foundation

final class NewsViewModel {

    let networkingService: NetworkingProtocol

    var newsListViewModel: [NewsListViewModel] = []

    enum NewVCSection {
        case main
    }

    var isLoading: Bool = true

    init(service: NetworkingProtocol) {
        self.networkingService = service
    }

    func fetchData(completion: @escaping(Result<[NewsListViewModel], Error>) -> Void) {
        isLoading = true
        guard let url = URL(string: "http://" + Configuration.getValueFor(key: AppConstants.baseURL)
                            + "?access_key=\(Configuration.getValueFor(key: AppConstants.apiKey))") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        networkingService.loadUsingModel(News.self, from: URLRequest(url: url)) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let newsData):
                self.newsListViewModel = newsData.data.map { NewsListViewModel($0)}
                completion(.success(self.newsListViewModel))
            case .failure(let error as NetworkError):
                switch error {
                case .invalidData:
                    completion(.failure(NetworkError.invalidData))
                case .invalidURL:
                    completion(.failure(NetworkError.invalidURL))
                case .invalidResponse:
                    completion(.failure(NetworkError.invalidResponse))
                case .decodingError:
                    print("Hello")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
