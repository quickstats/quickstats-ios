//
//  Sample.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/06.
//

import Foundation

public struct Sample: Codable {
    var value: Double
    var timestamp: Date

    struct List: Codable {
        var count: Int
        var next: URL?
        var prev: URL?
        var results: [Sample]
    }
}

extension Sample: Identifiable {
    public var id: String {
        timestamp.debugDescription
    }

}
