//
//  UserViewModel.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/4/22.
//

import Foundation

final class UserViewModel {

    // MARK: Netowrkign Service
    private let networkingService: NetworkingProtocol

    // list view model.
    var usersList: [UserListViewModel] = []

    // MARK: Init with networking protocol.
    init(networkingService: NetworkingProtocol) {
        self.networkingService = networkingService
    }

    var errorText: String?

    // MARK: Fetching data from network.

    var fetchCompleted: (([UserListViewModel]?, _ errorReason: String?) -> Void)?

    func fetchFromNetwork(from urlString: URL) {
        let request: URLRequest = URLRequest(url: urlString)
        networkingService.loadUsingModel([Response].self, from: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.usersList = response.map { .init(from: $0)}
                self.fetchCompleted?(self.usersList, nil)
            case .failure(let error as NetworkError):
                self.errorText = error.description
                self.fetchCompleted?([], self.errorText)
            case .failure(let error):
                self.errorText = "Uknown error \(error)"
                self.fetchCompleted?([], self.errorText)
            }
        }
    }

}
