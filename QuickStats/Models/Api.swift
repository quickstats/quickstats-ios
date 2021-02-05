//
//  Api.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import Foundation

class API: ObservableObject {
    func request(login: Login, path: String, qs: [URLQueryItem]) -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = login.domain
        components.path = path
        components.queryItems = qs

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return URLRequest(url: url)
    }
}
