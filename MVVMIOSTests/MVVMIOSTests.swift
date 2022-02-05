//
//  MVVMIOSTests.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 2/4/22.
//

import XCTest
@testable import MVVMIOS

class MockNetworkService: NetworkingProtocol {

    var result: Result<Response, NetworkError>

    init(result: Result<Response, NetworkError>) {
        self.result = result
    }

    func load(with request: URLRequest, completion: @escaping (Result<Response, NetworkError>) -> Void) {
        completion(result)
    }

}

class MVVMIOSTests: XCTestCase {

    public func testItFailsWhenAUrlIsInvalid() {
        let service = MockNetworkService(result: .failure(.invalidURL))
        let expectation = expectation(description: "It fails when there is an invalid url")
        let request = URLRequest(url: URL(string: "invalidURl")!)
        service.load(with: request) { result in
            expectation.fulfill()
            switch result {
            case .failure(let error):
                XCTAssertEqual(NetworkError.invalidURL, error)
            case .success:
                break
            }
        }

        waitForExpectations(timeout: 0.5, handler: nil)

    }
}
