//
//  NewsDataTests.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 2/13/22.
//

import XCTest
@testable import MVVMIOS

class NewsDataTests: XCTestCase {

    func testJsonDecoding() throws {
        guard let path = Bundle(for: NewsDataTests.self).path(forResource: "/NewsData", ofType: "json") else {
            preconditionFailure("could not find json file")
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let json = try JSONDecoder().decode(News<[NewsData]>.self, from: data)

        XCTAssertEqual(json.data.count, 25)
    }

}
