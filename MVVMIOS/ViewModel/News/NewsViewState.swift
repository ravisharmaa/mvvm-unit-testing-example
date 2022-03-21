//
//  NewsViewState.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 3/13/22.
//

import Foundation

enum NewsViewState {
    case error(NewsErrorViewState)
    case loaded(NewsLoadedViewState)
    case loading(NewsLoadingViewState)
}

struct NewsErrorViewState {
    let errorText: String
    let shouldShowSpinner: Bool
}

struct NewsLoadedViewState {

}

struct NewsLoadingViewState {
    let loadingText: String
    let shouldShowSpinner: Bool
}
