//
//  StubNewsData.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 2/23/22.
//

import Foundation

extension News {
    static var placeholder: News {
        return .init(data: [
            .init(id: UUID(), author: "test_author", title: "test_title",
                  description: "test_description", url: "test_url",
                  source: "test_source", category: "test_category",
                  language: "test_lan", country: "test_country"),
            .init(id: UUID(), author: "test_author", title: "test_title",
                  description: "test_description", url: "test_url",
                  source: "test_source", category: "test_category",
                  language: "test_lan", country: "test_country")
        ])
    }
}
