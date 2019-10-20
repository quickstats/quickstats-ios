//
//  Samples.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import Foundation

struct Sample: Codable {
    let timestamp: Date
    let value: Double
}

struct SampleResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Sample]
}

extension Sample {
    static func list(for widget: Widget, limit: Int = 100, completionHandler: @escaping ([Sample]) -> Void ) {
        let query = [URLQueryItem(name: "limit", value: String(limit))]

        authedRequest(path: "/api/widget/\(widget.id)/samples", method: "GET", queryItems: query, completionHandler: {_, data in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .custom(dateDecode)
                do {
                    let samples = try decoder.decode(SampleResponse.self, from: data)
                    completionHandler(samples.results)
                } catch let error {
                    print(error)
                    print(data.toString())
                }
            }
        })
    }
}
