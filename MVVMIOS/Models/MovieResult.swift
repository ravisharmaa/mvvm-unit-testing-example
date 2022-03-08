//
//  MovieResult.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 3/6/22.
//

import Foundation

struct MovieResult: Codable {
    let id: Int
    let name, coverImage, welcomeDescription, timePeriod: String
    let references: String
    let sortOrder: Int
    let createdAt, updatedAt: String
    let uuid: UUID

    enum CodingKeys: String, CodingKey {
        case id, name
        case coverImage = "cover_image"
        case welcomeDescription = "description"
        case timePeriod = "time_period"
        case references
        case sortOrder = "sort_order"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case uuid
    }
}
