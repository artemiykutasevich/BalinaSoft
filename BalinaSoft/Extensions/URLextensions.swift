//
//  URLextensions.swift
//  BalinaSoft
//
//  Created by Artem Kutasevich on 5.05.22.
//

import Foundation

extension URL {
    static func url(with path: String, requestType: String, queryParams: JSONDict?) -> URL? {
        guard let url = URL(string: path)?.appendingPathComponent(requestType),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        
        guard let queryParams = queryParams else {
            return urlComponents.url
        }

        urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0, value: "\($1)") }
        return urlComponents.url
    }
}
