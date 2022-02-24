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

    init(service: NetworkingProtocol) {
        self.networkingService = service
    }

    func fetchData(completion: @escaping(Result<[NewsListViewModel], Error>) -> Void) {

        guard let url = URL(string: "https://" + Configuration.getValueFor(key: AppConstants.baseURL)
                            + "?access_token=\(Configuration.getValueFor(key: AppConstants.apiKey))") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        print(url)

        networkingService.loadUsingModel(News.self, from: URLRequest(url: url)) { [weak self] result in
            guard let self = self else { return }
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
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
