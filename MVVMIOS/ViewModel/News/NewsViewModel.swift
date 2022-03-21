//
//  NewsViewModel.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/13/22.
//

import Foundation

protocol NewsViewDataPresentable: AnyObject {
    func viewStateFor(_ state: NewsViewState)
}

final class NewsViewModel {

    let networkingService: NetworkingProtocol
    let urlManager: URLManagerProtocol

    weak var newsViewPresentable: NewsViewDataPresentable?

    enum NewVCSection {
        case main
    }

    init(service: NetworkingProtocol, urlManager: URLManagerProtocol) {
        self.networkingService = service
        self.urlManager = urlManager
    }

    func fetchData(completion: @escaping(Result<[NewsListViewModel], Error>) -> Void) {

    }

    func getDataFromApi() {

        newsViewPresentable?.viewStateFor(setLoadingViewState())

        guard var url = urlManager.prepareURL(withString: "http://" +
                                              Configuration.getValueFor(key: AppConstants.baseURL)) else {
            self.newsViewPresentable?.viewStateFor(viewStateForError(NetworkError.invalidURL))
            return
        }

        url.appendPathComponent("?access_key=\(Configuration.getValueFor(key: AppConstants.apiKey))")
    }

    internal func setLoadingViewState() -> NewsViewState {
        return .loading(.init(loadingText: "Loading...", shouldShowSpinner: true))
    }

    internal func viewStateForError(_ error: Error) -> NewsViewState {
        guard let error = error as? NetworkError else {
            return .error(.init(errorText: "Unknown error", shouldShowSpinner: true))
        }

        return .error(.init(errorText: error.description, shouldShowSpinner: false))
    }

}
