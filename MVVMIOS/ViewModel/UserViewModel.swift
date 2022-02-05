//
//  UserViewModel.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/4/22.
//

import Foundation

final class UserViewModel: NSObject {

    fileprivate let networkingService: NetworkingProtocol

    init(networkingService: NetworkingProtocol = NetworkingService()) {
        self.networkingService = networkingService
    }

    func fetchFromNetwork() {

    }

}
