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
    case invalidData
    case decodingError
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidURL:
            return "The url in invalid."
        case .invalidResponse:
            return "The response is invalid."
        case .invalidData:
            return "The data is invalid."
        case .decodingError:
            return "Could not decode the response"
        }
    }
}

protocol NetworkingProtocol {
    func loadUsingModel <T: Codable>(_ using: T.Type,
                                     from request: URLRequest, then completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkingService: NetworkingProtocol {

    func loadUsingModel<T: Codable>(_ using: T.Type,
                                    from request: URLRequest, then completion: @escaping (Result<T, Error>) -> Void) {
        if let url = request.url, UIApplication.shared.canOpenURL(url) {
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                    return

                } catch {
                    completion(.failure(NetworkError.decodingError))
                    return
                }

            }.resume()
        } else {
            completion(.failure(NetworkError.invalidURL as Error))
            return
        }

    }
}
