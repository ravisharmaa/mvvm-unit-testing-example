//
//  NewsListViewModel.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/18/22.
//

import Foundation

final class NewsListViewModel: Equatable {

    static func == (lhs: NewsListViewModel, rhs: NewsListViewModel) -> Bool {
        return lhs.newsData.category == rhs.newsData.category
    }

    let newsData: NewsData

    init(_ fromData: NewsData) {
        self.newsData = fromData
    }

    var newsCategory: String {
        return newsData.category ?? "Unavailable"
    }
}
