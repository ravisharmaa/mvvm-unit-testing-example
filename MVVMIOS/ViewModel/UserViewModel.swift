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

    func fetchFromNetwork(from urlString: URL) {
        let request: URLRequest = URLRequest(url: urlString)
        networkingService.loadUsingModel(Response.self, from: request) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
