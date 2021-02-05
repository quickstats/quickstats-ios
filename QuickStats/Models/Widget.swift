//
//  Widget.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import Foundation
import SwiftUI

enum WidgetType: String, CaseIterable, Identifiable, Codable {
    case countdown = "Countdown"
    case chart = "Chart"
    case location = "Location"
    case streak = "Streak"

    var id: String { self.rawValue }
}

struct Widget: Codable, Identifiable {
    var id: UUID
    var title: String
    var description: String
    var value: Double
    var type: WidgetType

    struct List: Codable {
        var count: Int
        var next: URL?
        var prev: URL?
        var results: [Widget]
    }
}

extension Widget {
    var color: Color {
        switch type {
        case .chart:
            return .green
        case .countdown:
            return .red
        case .location:
            return .blue
        case .streak:
            return .orange
        }
    }
}
