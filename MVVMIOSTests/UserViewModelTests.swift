//
//  UserViewModelTests.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 2/6/22.
//

import XCTest
@testable import MVVMIOS

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

class UserViewModelTests: XCTestCase {

    var sut: UserViewModel?

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTheUserListIsNotPopulatedWhenAnInvalidUrlIsSent() {
        let networkingClient: MockNetworkClient = MockNetworkClient()
        networkingClient.result = Result<Response, Error>.failure(NetworkError.invalidURL as Error)
        sut = makeSut(usingClient: networkingClient)
        let invalidURl = URL(string: "https://aaasdfasf-url")!
        sut?.fetchFromNetwork(from: invalidURl)
        XCTAssertTrue(sut?.usersList.count == 0)
    }

    func testTheUserListDoesNotPopulateIfTheResposneIsNot200() {
        let networkingClient: MockNetworkClient = MockNetworkClient()
        networkingClient.result = Result<Response, Error>.failure(NetworkError.invalidURL as Error)
        sut = makeSut(usingClient: networkingClient)
        let urlwhichDoesNotRespondWith200 = URL(string: "https://searchy.search.com")!
        sut?.fetchFromNetwork(from: urlwhichDoesNotRespondWith200)
        XCTAssertTrue(sut?.usersList.count == 0)
    }

//    func testTheUserListIsParsedProperly() {
//        let sampleJson =    """
//                            {
//                                "name": "Test User"
//                            }
//                            """
//        let jsonData = sampleJson.data(using: .utf8)!
//        sut = makeSut(withResult: .success(jsonData))
//        let expectation = expectation(description: "It gets appropriate data")
//        let expectedServerResponse: [UserListViewModel] = [UserListViewModel(from: .init(name: "Test User"))]
//        let url = URL(string: "https://a-valid-url.com")!
//        sut?.fetchFromNetwork(from: url)
//        expectation.fulfill()
//        wait(for: [expectation], timeout: 0.5)
//
//        XCTAssertEqual(expectedServerResponse.count, sut?.usersList.count)
//
//    }

//    func testTheUserListGetsPopulated() {
//        let sampleJson =    """
//                            {
//                                "name": "Test User"
//                            }
//                            """
//        let jsonData = sampleJson.data(using: .utf8)!
//        let networkingClient: MockNetworkClient = MockNetworkClient(withResult: .success(jsonData))
//        sut =  UserViewModel(networkingService: networkingClient)
//        let response: Response = .init(name: "Hell world")
//        networkingClient.resultOne = Result<Response, Error>.success(response)
//        let url = URL(string: "https://a-valid-url.com")!
//        sut?.fetchData(from: url)
//    }

    private func makeSut(usingClient: MockNetworkClient) -> UserViewModel {
        return UserViewModel(networkingService: usingClient)
    }

}
