//
//  NetworkService.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/4/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

protocol NetworkingProtocol {

    func load(with request: URLRequest, completion: @escaping (Result<Response, NetworkError>) -> Void)
}

final class NetworkingService: NetworkingProtocol {

    func load(with request: URLRequest, completion: @escaping (Result<Response, NetworkError>) -> Void) {

    }
}
