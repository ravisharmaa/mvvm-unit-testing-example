//
//  UserViewModelTests.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 2/6/22.
//

import XCTest
@testable import MVVMIOS

class UserViewModelTests: XCTestCase {

    var sut: UserViewModel?
    var networkingClient: MockNetworkClient!

    override func setUp() {
        networkingClient = MockNetworkClient()
        sut = UserViewModel(networkingService: networkingClient)
    }

    override func tearDownWithError() throws {
        sut = nil
        networkingClient = nil
    }

    func testTheUserListIsNotPopulatedWhenThereIsAnInvalidUrl() {
        networkingClient.result = Result<[Response], Error>.failure(NetworkError.invalidURL as Error)
        let invalidURl = URL(string: "https://aaasdfasf-url")!
        sut?.fetchFromNetwork(from: invalidURl)
        XCTAssertTrue(sut?.usersList.count == 0)
    }

    func testTheUserListIsNotPopulatedWhenTheResponseIsNotSuccessFul() {
        // given
        networkingClient.result = Result<[Response], Error>.failure(NetworkError.invalidURL as Error)
        let validURl = URL(string: "https://search.search.com")!
        // when
        sut?.fetchFromNetwork(from: validURl)
        // then
        XCTAssertTrue(sut?.usersList.count == 0)
    }

    func testTheUserListsGetsPopulatedWhenThereIsACorrectResponse() {

        networkingClient.result = Result<[Response], Error>.success([
            .init(name: "A new response"),
            .init(name: "A Second User")
        ])

        let validURl = URL(string: "https://search.search.com")!

        sut?.fetchFromNetwork(from: validURl)

        XCTAssertTrue(sut?.usersList.count == 2)
    }

    func testTheErrorIsSetWhenTheResponseIsNotCorrect() {
        networkingClient.result = Result<[Response], Error>.failure(NetworkError.invalidURL as Error)
        let invalidURl = URL(string: "https://aaasdfasf-url")!
        sut?.fetchFromNetwork(from: invalidURl)
        XCTAssertNotNil(sut?.errorText)
    }

}
