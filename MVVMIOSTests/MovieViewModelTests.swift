//
//  MovieViewModelTests.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 3/6/22.
//

import XCTest

class MockResultPresentable: MovieViewModelResultPresentable {

    var resultsArray: [Result<[MovieResult], Error>] = []

    func presentResult(_ result: Result<[MovieResult], Error>?) {
        resultsArray.append(result!)
    }

}

class MovieViewModelTests: XCTestCase {

    var service: MockNetworkClient!
    var viewModel: MovieViewModel!
    var resultPresentable: MockResultPresentable!

    override func setUp() {
        resultPresentable = MockResultPresentable()
        service = MockNetworkClient()
        viewModel = MovieViewModel(service)
        viewModel.resultPresentable = resultPresentable
    }

    override func tearDown() {
        service = nil
        viewModel = nil
        resultPresentable = nil
    }

    func testItDoesNotLoadDataWhenTheUrlIsInvalid() {
        service.result = Result<[MovieResult], Error>.failure(NetworkError.invalidURL)
        viewModel.fetchDataFromApi()
        XCTAssertEqual(resultPresentable.resultsArray.count, 1)
        switch resultPresentable.resultsArray[0] {
        case .success:
            XCTFail("No error should be present")
        case .failure(let error):
            // swiftlint:disable force_cast
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidURL)
            // swiftlint:enable force_cast
        }

    }
}
