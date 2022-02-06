//
//  UserViewModelTests.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 2/6/22.
//

import XCTest
@testable import MVVMIOS

final class MockNetworkClient: NetworkingProtocol {

    func load<T: Codable>(_ type: T.Type,
                          from request: URLRequest,
                          then completion: @escaping (Result<T, Error>) -> Void) {
        completion(.success(T))
    }
}

class UserViewModelTests: XCTestCase {

    var sut: UserViewModel?

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTheUserListIsNotPopulatedWhenAnInvalidUrlIsSent() {
        sut = makeSut(withResult: .failure(NetworkError.invalidURL as Error))
        let invalidURl = URL(string: "https://aaasdfasf-url")!
        sut?.fetchFromNetwork(from: invalidURl)
        XCTAssertTrue(sut?.usersList.count == 0)
        XCTAssertNotNil(sut?.errorText)
    }

    func testTheUserListDoesNotPopulateIfTheResposneIsNot200() {
        sut = makeSut(withResult: .failure(NetworkError.invalidResponse as Error))
        let urlwhichDoesNotRespondWith200 = URL(string: "https://searchy.search.com")!
        sut?.fetchFromNetwork(from: urlwhichDoesNotRespondWith200)
        XCTAssertTrue(sut?.usersList.count == 0)

    }

    private func makeSut(withResult: Result<Response, Error>) -> UserViewModel {
        let networkingClient: NetworkingProtocol = MockNetworkClient()
        networkingClient.result =
        return UserViewModel(networkingService: networkingClient)
    }

}
