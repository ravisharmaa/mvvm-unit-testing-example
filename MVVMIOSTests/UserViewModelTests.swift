//
//  UserViewModelTests.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 2/6/22.
//

import XCTest
@testable import MVVMIOS

final class MockNetworkClient: NetworkingProtocol {

    var result: Result<Data, Error>

    init(withResult: Result<Data, Error>) {
        self.result = withResult
    }

    func load(from request: URLRequest, then completion: @escaping (Result<Data, Error>) -> Void) {
        completion(result)
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
    }

    func testTheUserListDoesNotPopulateIfTheResposneIsNot200() {
        sut = makeSut(withResult: .failure(NetworkError.invalidResponse as Error))
        let urlwhichDoesNotRespondWith200 = URL(string: "https://searchy.search.com")!
        sut?.fetchFromNetwork(from: urlwhichDoesNotRespondWith200)
        XCTAssertTrue(sut?.usersList.count == 0)
    }

    func testTheUserListIsParsedProperly() {
        let sampleJson =    """
                            {
                                "name": "Test User"
                            }
                            """
        let jsonData = sampleJson.data(using: .utf8)!
        sut = makeSut(withResult: .success(jsonData))
        let expectation = expectation(description: "It gets appropriate data")
        let expectedServerResponse: [UserListViewModel] = [UserListViewModel(from: .init(name: "Test User"))]
        let url = URL(string: "https://a-valid-url.com")!
        sut?.fetchFromNetwork(from: url)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(expectedServerResponse.count, sut?.usersList.count)

    }

    private func makeSut(withResult: Result<Data, Error>) -> UserViewModel {
        let networkingClient: NetworkingProtocol = MockNetworkClient(withResult: withResult)
        return UserViewModel(networkingService: networkingClient)
    }

}
