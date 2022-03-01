//
//  NewsListViewModelTests.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 2/22/22.
//

import XCTest

class NewsListViewModelTests: XCTestCase {

    var sut: NewsListViewModel?

    func testItGetsIntializedWithAppropriateData() {
        let data = NewsData(author: "", title: "", description: "",
                            url: "", source: "", category: "", language: "", country: "")
        sut = NewsListViewModel(data)
        XCTAssertNotNil(sut?.newsData)
    }
//
    func testItformatsTheCategoryToUnavailableWhenNil() {
        let data = NewsData(author: "", title: "", description: "",
                            url: "", source: "", category: nil, language: "", country: "")
        sut = NewsListViewModel(data)
        XCTAssertNil(sut?.newsData.category)
        XCTAssertEqual(sut?.newsCategory, "Unavailable")
    }

}
