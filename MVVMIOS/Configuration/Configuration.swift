//
//  Configuration.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/23/22.
//

import Foundation

// MARK: Application Constants
struct AppConstants {
    static let apiKey: String = "Api Key"
    static let baseURL: String = "Base Url"

}

// MARK: Reads value from Info.plist for given key. Here it is assumed that the value will only be string.

enum Configuration {
    static func getValueFor(key: String) -> String {
        return Bundle.main.infoDictionary?[key] as? String ?? ""
    }
}
