//
//  NetworkServiceMock.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 2/13/22.
//

import Foundation

final class MockNetworkClient: NetworkingProtocol {

    var result: Any?

    func loadUsingModel<T: Codable>(_ using: T.Type,
                                    from request: URLRequest,
                                    then completion: @escaping (Result<T, Error>) -> Void) {
        // swiftlint:disable force_cast
        completion(result as! Result<T, Error>)
        // swiftlint:enable force_cast

    }
}
