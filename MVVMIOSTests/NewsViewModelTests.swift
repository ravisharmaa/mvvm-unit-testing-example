//
//  NewsViewModelTests.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 2/18/22.
//

import XCTest
@testable import MVVMIOS

class NewsViewModelTests: XCTestCase {

    var newsViewModel: NewsViewModel!
    var mockNetworkingService: MockNetworkClient!

    override func setUp() {
        mockNetworkingService = MockNetworkClient()
        newsViewModel = NewsViewModel(service: mockNetworkingService)
    }

    override func tearDown() {
        mockNetworkingService = nil
        newsViewModel = nil
    }

    func testItGetsInitilizedWithAService() {
        XCTAssertNotNil(newsViewModel.networkingService)
    }

    func testItSetsIsLoadingToFalseWhenInitialized() {
        XCTAssertFalse(newsViewModel.isLoading)
    }

    func testItSetsLoadinToFalseAfterDataIsFetched() {
        mockNetworkingService.result = Result<News, Error>.failure(NetworkError.invalidURL)
        XCTAssertFalse(newsViewModel.isLoading)
        newsViewModel.fetchData { _ in
//            XCTAssertTrue(self.newsViewModel.isLoading)
        }
        XCTAssertFalse(newsViewModel.isLoading)
    }

    func testItThrowsInvalidUrlErrorWhenTheUrlIsInvalid() {
        mockNetworkingService.result = Result<News, Error>.failure(NetworkError.invalidURL)
        var fetchedDataResults: [Result<[NewsListViewModel], Error>] = []
        newsViewModel.fetchData { fetchedDataResults.append($0) }
        XCTAssertEqual(fetchedDataResults.count, 1)
        switch fetchedDataResults[0] {
        case .success:
            XCTFail("Error should be thrown.")
        case .failure(let error):
            // swiftlint:disable force_cast
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidURL)
            // swiftlint:enable force_cast
        }
    }

    func testItThorwsInvalidDataWhenTheDataIsNotAppropriate() {
        mockNetworkingService.result = Result<News, Error>.failure(NetworkError.invalidData)
        var fetchedDataResults: [Result<[NewsListViewModel], Error>] = []
        newsViewModel.fetchData { fetchedDataResults.append($0) }
        XCTAssertEqual(fetchedDataResults.count, 1)
        switch fetchedDataResults[0] {
        case .success:
            XCTFail("Error should be thrown.")
        case .failure(let error):
            // swiftlint:disable force_cast
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidData)
            // swiftlint:enable force_cast
        }
    }

    func testItThrowsInvalidResponseWhenTheResponseIsInvalid() {
        mockNetworkingService.result = Result<News, Error>.failure(NetworkError.invalidResponse)
        var fetchedDataResults: [Result<[NewsListViewModel], Error>] = []
        newsViewModel.fetchData { fetchedDataResults.append($0) }
        XCTAssertEqual(fetchedDataResults.count, 1)
        switch fetchedDataResults[0] {
        case .success:
            XCTFail("Error should be thrown.")
        case .failure(let error):
            // swiftlint:disable force_cast
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponse)
            XCTAssertNotEqual(error as! NetworkError, NetworkError.invalidURL)
            // swiftlint:enable force_cast
        }
    }

    func testItParsesDataProperlyWhenTheResponseIsValid() {
        mockNetworkingService.result = Result<News, Error>.success(News.placeholder)
        var fetchedDataResults: [Result<[NewsListViewModel], Error>] = []
        newsViewModel.fetchData { fetchedDataResults.append($0) }
        XCTAssertEqual(fetchedDataResults.count, 1)
        switch fetchedDataResults[0] {
        case .success(let data):
            XCTAssertEqual(data.count, 2)
            XCTAssertEqual(data[0].newsCategory, "test_category")
        case .failure:
            XCTFail("No Error should be thrown.")
        }
    }
}
