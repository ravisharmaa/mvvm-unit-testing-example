//
//  UserListViewModelTest.swift
//  MVVMIOSTests
//
//  Created by Ravi Bastola on 2/8/22.
//

import XCTest
@testable import MVVMIOS

class UserListViewModelTest: XCTestCase {

    var sut: UserListViewModel!
    var response: Response!

    func testItGetsInitializedWithResponseObject() {
        response = .init(name: "A new response")
        sut = UserListViewModel(from: response)
        XCTAssertEqual(response, sut.response)
    }

    func testItHasAFullName() {
        response = .init(name: "A new response")
        sut = UserListViewModel(from: response)
        XCTAssertEqual("A new responseA new response", sut.fullName)
    }

}
