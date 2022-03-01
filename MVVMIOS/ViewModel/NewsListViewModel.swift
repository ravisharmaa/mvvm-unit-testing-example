//
//  NewsListViewModel.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/18/22.
//

import Foundation

final class NewsListViewModel: Equatable, Hashable {

    static func == (lhs: NewsListViewModel, rhs: NewsListViewModel) -> Bool {
        return lhs.newsData.id == rhs.newsData.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(newsData.id)
    }

    let newsData: NewsData

    init(_ fromData: NewsData) {
        self.newsData = fromData
    }

    var newsCategory: String {
        return newsData.category ?? "Unavailable"
    }

    var newsDescription: String {
        return newsData.description ?? "N/A"
    }
}
