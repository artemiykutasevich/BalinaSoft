//
//  NetworkResponse.swift
//  BalinaSoft
//
//  Created by Artem Kutasevich on 5.05.22.
//

import Foundation

struct NetworkResponse: Codable {
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let totalElements: Int
    let tapeOfImages: [NetworkImage]
    
    enum CodingKeys: String, CodingKey {
        case page
        case pageSize
        case totalPages
        case totalElements
        case tapeOfImages = "content"
    }
}

struct NetworkImage: Codable, Identifiable, Equatable {
    let id: Int
    let imageTitle: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageTitle = "name"
        case imageURL = "image"
    }
}
