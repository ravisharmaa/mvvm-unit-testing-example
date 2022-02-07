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
}

protocol NetworkingProtocol {
    func load(from request: URLRequest, then completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkingService: NetworkingProtocol {
    
    func load(from request: URLRequest, then completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = request.url, UIApplication.shared.canOpenURL(url) {
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode != 200 else {
                    completion(.failure(NetworkError.invalidResponse as Error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NetworkError.invalidData as Error))
                    return
                }
                
                completion(.success(data))
            }.resume()
        } else {
            completion(.failure(NetworkError.invalidURL as Error))
            return
        }
    }
}
