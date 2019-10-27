//
//  Widget.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import Foundation
import UIKit

enum WidgetType: String, Codable {
    case Chart
    case Countdown
    case Location
}

struct Widget: Codable {
    let owner: String
    let id: String
    let timestamp: Date
    let title: String
    let description: String
    let icon: URL?
    let value: Double
    let more: URL?
    let type: WidgetType
    let publicWidget: Bool

    private enum CodingKeys: String, CodingKey {
        case owner
        case id
        case timestamp
        case title
        case description
        case icon
        case value
        case more
        case type
        case publicWidget = "public"
    }
}

struct WidgetResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Widget]
}

// MARK: - API

extension Widget {
    func create(completionHandler: @escaping (Widget) -> Void) {
        guard let username = Settings.shared.string(forKey: .username) else { return }
        guard let password = Settings.keychain.string(forKey: .server) else { return    }
        let body = self.encode()

        authedRequest(path: "/api/widget", method: "POST", body: body, username: username, password: password) { _, data in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(dateDecode)
            do {
                let widget = try decoder.decode(Widget.self, from: data)
                completionHandler(widget)
            } catch let error {
                print(data.toString())
                print(error)
            }
        }
    }

    func subscribe(completionHandler: @escaping (Widget) -> Void) {
        authedRequest(path: "/api/widget/\(self.id)/subscribe", method: "POST", queryItems: []) { (_, data) in
            print(data)
        }
    }

    func unsubscribe(completionHandler: @escaping (Widget) -> Void) {

    }

    static func subscriptions(completionHandler: @escaping ([Widget]) -> Void) {
        let query = [URLQueryItem(name: "limit", value: "100")]

        authedRequest(path: "/api/subscription", method: "GET", queryItems: query, completionHandler: {_, data in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .custom(dateDecode)
                do {
                    let widgets = try decoder.decode(WidgetResponse.self, from: data)
                    completionHandler(widgets.results)
                } catch let error {
                    print(error)
                }
            }
        })
    }

    static func list(completionHandler: @escaping ([Widget]) -> Void) {
        let query = [URLQueryItem(name: "limit", value: "100")]

        authedRequest(path: "/api/widget", method: "GET", queryItems: query, completionHandler: {_, data in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .custom(dateDecode)
                do {
                    let widgets = try decoder.decode(WidgetResponse.self, from: data)
                    completionHandler(widgets.results)
                } catch let error {
                    print(error)
                }
            }
        })
    }

    func encode() -> Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        do {
            let data = try encoder.encode(self)
            return data
        } catch let error {
            print(error)
        }
        return nil
    }
}
