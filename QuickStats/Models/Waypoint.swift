//
//  Waypoint.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/10/14.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import Foundation

struct Waypoint: Codable {
    let timestamp: Date
    let body: String
    let lat: Float
    let lon: Float
    let state: String
}

struct WaypointResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Waypoint]
}

extension Waypoint {
    static func list(for widget: Widget, limit: Int = 100, completionHandler: @escaping ([Waypoint]) -> Void ) {
        let query = [URLQueryItem(name: "limit", value: String(limit))]

        authedRequest(path: "/api/widget/\(widget.id)/waypoints", method: "GET", queryItems: query, completionHandler: {_, data in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .custom(dateDecode)
                do {
                    let waypoints = try decoder.decode(WaypointResponse.self, from: data)
                    completionHandler(waypoints.results)
                } catch let error {
                    print(error)
                    print(data.toString())
                }
            }
        })
    }
}
