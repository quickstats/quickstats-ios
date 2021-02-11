//
//  Waypoint.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/11.
//

import Foundation

enum WaypointState: String, Codable {
    case leave
    case enter
    case waypoint
}

struct Waypoint: Codable {
    let timestamp: Date
    let body: String
    let lat: Double
    let lon: Double
    let state: WaypointState

    struct List: Codable {
        var count: Int
        var next: URL?
        var prev: URL?
        var results: [Waypoint]
    }
}

extension Waypoint: Identifiable {
    public var id: String {
        timestamp.debugDescription
    }
}
