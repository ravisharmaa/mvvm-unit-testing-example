//
//  UserListViewModel.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/4/22.
//

import Foundation

final class UserListViewModel {

    let response: Response

    init(from response: Response) {
        self.response = response
    }

    var fullName: String {
        response.name + response.name
    }
}
