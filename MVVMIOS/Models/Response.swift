//
//  Response.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/4/22.
//

import Foundation

struct Response: Codable, Equatable {
    let name: String
}

struct News<T: Codable>: Codable {
    let data: T
}

struct Pagination: Codable {

}

struct NewsData: Codable {
    let id: UUID = UUID()
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let source: String?
    let category: String?
    let language: String?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case id
        case author, title, description, url, source, category, language, country
    }

    static var placeholder: [NewsData] {
        return [
            .init(author: "test_author", title: "test_title",
                  description: "test_description", url: "test_url",
                  source: "test_source", category: "test_category",
                  language: "test_lan", country: "test_country"),
            .init(author: "test_author", title: "test_title",
                  description: "test_description", url: "test_url",
                  source: "test_source", category: "test_category",
                  language: "test_lan", country: "test_country")
        ]
    }
}
