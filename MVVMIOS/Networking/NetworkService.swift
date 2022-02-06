//
//  NetworkService.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/4/22.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

protocol NetworkingProtocol {
    func load<T: Codable>(_ type: T.Type,
                          from request: URLRequest, then completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkingService: NetworkingProtocol {
    func load<T>(_ type: T.Type,
                 from request: URLRequest,
                 then completion: @escaping (Result<T, Error>) -> Void) {

        if let url = request.url, UIApplication.shared.canOpenURL(url) {
        } else {
            completion(.failure(NetworkError.invalidURL as Error))
            return
        }

    }

}
