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

    func fetchData(forURL: String, completion: @escaping(Result<[NewsListViewModel], Error>) -> Void) {

        guard let url = URL(string: "https://news-api.org") else {
            completion(.failure(NetworkError.invalidURL as Error))
            return
        }

        networkingService.loadUsingModel(News<[NewsData]>.self, from: URLRequest(url: url)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newsData):
                self.newsListViewModel = newsData.data.map { NewsListViewModel($0)}
                completion(.success(self.newsListViewModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
