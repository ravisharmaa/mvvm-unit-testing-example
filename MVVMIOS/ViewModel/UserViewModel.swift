//
//  UserViewModel.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/4/22.
//

import Foundation

final class UserViewModel {

    private let networkingService: NetworkingProtocol

    init(networkingService: NetworkingProtocol) {
        self.networkingService = networkingService
    }

    func fetchFromNetwork() {

    }

}
