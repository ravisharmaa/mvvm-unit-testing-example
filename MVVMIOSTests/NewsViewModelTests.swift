//
//  NewsViewModelTests.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 2/18/22.
//

import XCTest
@testable import MVVMIOS

class NewsViewModelTests: XCTestCase {

    var sut: NewsViewModel!

    func testItGetsInitilizedWithAService() {
        let mockService: MockNetworkClient = MockNetworkClient()
        sut = NewsViewModel(service: mockService)
        XCTAssertNotNil(sut.networkingService)
    }

    func testItThrowsInvalidUrlErrorWhenTheUrlIsInvalid() {
        let mockService: MockNetworkClient = MockNetworkClient()
        mockService.result = Result<News<[NewsData]>, Error>.failure(NetworkError.invalidURL as Error)
        sut = NewsViewModel(service: mockService)
        sut.fetchData(forURL: "http://invalid.url") { result in
            switch result {
            case .success:
                XCTFail("No error thrown")
            case .failure(let error):
                XCTAssertEqual(NetworkError.invalidURL.localizedDescription, error.localizedDescription)
            }
        }
    }

    func testItFetchesDataFromNetwork() {
        let mockService: MockNetworkClient = MockNetworkClient()
        let newsData: NewsData =
            .init(author: "Test Author", title: "TestTitle", description: "Test Description",
                  url: "random url", source: "random source", category: "random Category",
                  language: "random language", country: "random country")
        let data: News<[NewsData]> = .init(data: [newsData])
        mockService.result = Result<News<[NewsData]>, Error>.success(data)
        sut = NewsViewModel(service: mockService)
        let expectedResult: [NewsListViewModel] = [
            .init(newsData)
        ]

        sut.fetchData(forURL: "https://news-api.org") { result in
            switch result {
            case .success(let data):
                XCTAssertTrue(data.count == 1)
                XCTAssertEqual(expectedResult, data)
            case .failure:
                XCTFail("No error thrown")
            }
        }

    }
}
