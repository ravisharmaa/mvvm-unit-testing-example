//
//  MovieState.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 3/8/22.
//

import Foundation

enum MovieViewState {
    case error(MovieErrorViewState)
    case loading(MovieLoadingViewState)
    case loaded(MovieLoadedViewState)

}

struct MovieErrorViewState {
    let errorText: String
    let isLoading: Bool
}

struct MovieLoadingViewState {
    let loadingText: String
    let loaderStatus: Bool
}

struct MovieViewData: Hashable {
    let title: String
    let name: String
}

struct MovieLoadedViewState {
    let movies: [MovieViewData]
    let isLoaded: Bool
}
