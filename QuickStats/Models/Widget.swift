//
//  Widget.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import Foundation

struct Widget: Codable {
    var id: UUID
    var title: String
    var description: String

    struct List: Codable {
        var count: Int
        var next: URL?
        var prev: URL?
        var results: [Widget]
    }
}
