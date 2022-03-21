//
//  NewsViewModelTest.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 3/13/22.
//

import XCTest

class MockNewsViewPresentable: NewsViewDataPresentable {

    var newsViewState: [NewsViewState] = []

    func viewStateFor(_ state: NewsViewState) {
        self.newsViewState.append(state)
    }

}

class NewsViewModelTest: XCTestCase {

    var networkService: MockNetworkClient!
    var viewModel: NewsViewModel!
    var urlManager: MockUrlManager!
    var resultPresentable: MockNewsViewPresentable!

    override func setUp() {
        networkService = MockNetworkClient()
        urlManager =  MockUrlManager()
        resultPresentable = MockNewsViewPresentable()
        viewModel = .init(service: networkService, urlManager: urlManager)
        viewModel.newsViewPresentable = resultPresentable
    }

    override func tearDown() {
        networkService = nil
        urlManager = nil
        resultPresentable = nil
        viewModel = nil
    }

    func testItSetsViewStateToErrorWhenAnInavlidUrlIsSent() {
        urlManager.url = nil
        networkService.result = Result<[News], Error>.failure(NetworkError.invalidURL)
        viewModel.getDataFromApi()
        XCTAssertEqual(resultPresentable.newsViewState.count, 2)
        switch resultPresentable.newsViewState[1] {
        case .error(let error):
            XCTAssertEqual(error.shouldShowSpinner, false)
            XCTAssertEqual(error.errorText, "The url is invalid.")
        case .loaded:
            XCTFail("No error should be present")
        case .loading:
            XCTFail("No error should be present")
        }
    }

    func testItSetsViewStateForUnkownErrors() {

    }

}
