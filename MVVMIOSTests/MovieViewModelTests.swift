//
//  MovieViewModelTests.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 3/6/22.
//

import XCTest

class MockResultPresentable: MovieViewModelResultPresentable {

    var resultsArray: [Result<[MovieResult], Error>] = []

    var movieViewState: [MovieViewState] = []

    func presentResult(_ result: Result<[MovieResult], Error>?) {
        resultsArray.append(result!)
    }

    func setupViewState(_ with: MovieViewState) {
        self.movieViewState.append(with)
    }

}

class MockUrlManager: URLManagerProtocol {

    var url: String?

    func prepareURL(withString: String) -> URL? {
        guard let url = url else {
            return nil
        }

        return URL(string: url)

    }
}

class MovieViewModelTests: XCTestCase {

    var service: MockNetworkClient!
    var viewModel: MovieViewModel!
    var resultPresentable: MockResultPresentable!
    var mockURLManager: MockUrlManager!

    override func setUp() {
        resultPresentable = MockResultPresentable()
        service = MockNetworkClient()
        mockURLManager = MockUrlManager()
        viewModel = MovieViewModel(service, urlManager: mockURLManager)
        viewModel.resultPresentable = resultPresentable
    }

    override func tearDown() {
        service = nil
        viewModel = nil
        resultPresentable = nil
        mockURLManager = nil
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

    func testItDoesNotLoadDataWhenTheDataCannotBeDecoded() {
        service.result = Result<[MovieResult], Error>.failure(NetworkError.invalidResponse)
        viewModel.fetchDataFromApi()
        XCTAssertEqual(resultPresentable.resultsArray.count, 1)
        switch resultPresentable.resultsArray[0] {
        case .success:
            XCTFail("No error should be present")
        case .failure(let error):
            // swiftlint:disable force_cast
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponse)
            // swiftlint:enable force_cast
        }
    }

    func testItPopulatesErrorProperlyWhenTheURLIsInvalid() {
        mockURLManager.url = nil
        service.result = Result<[MovieResult], Error>.failure(NetworkError.invalidURL)
        viewModel.getDataFromApi()
        XCTAssertEqual(resultPresentable.movieViewState.count, 1)
        switch resultPresentable.movieViewState[0] {
        case .error(let error):
            XCTAssertEqual(error.isLoading, false)
            XCTAssertEqual(error.errorText, "The url is invalid.")
        case .loaded:
            XCTFail("No error should be present")
        case .loading:
            XCTFail("No error should be present")
        }
    }

    func testItPopulatesErrorProperlyWhenTheResponseIsInvalid() {
        mockURLManager.url = "https://valid.url.com"
        service.result = Result<[MovieResult], Error>.failure(NetworkError.invalidResponse)
        viewModel.getDataFromApi()
        XCTAssertEqual(resultPresentable.movieViewState.count, 1)
        switch resultPresentable.movieViewState[0] {
        case .error(let error):
            XCTAssertEqual(error.isLoading, false)
            XCTAssertEqual(error.errorText, "The response is invalid.")
        case .loaded:
            XCTFail("No error should be present")
        case .loading:
            XCTFail("No error should be present")
        }

    }

}