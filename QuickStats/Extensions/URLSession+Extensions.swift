//
//  URLSession+Extensions.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import Foundation
import os.log

extension URLRequest {
    mutating func addBasicAuth(username: String, password: String) {
        let loginString = "\(username):\(password)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
    }

    mutating func addBody<T: Encodable>(object: T) {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        do {
            httpBody = try encoder.encode(object)
            addValue("application/json", forHTTPHeaderField: "Content-Type")
            addValue("application/json", forHTTPHeaderField: "Accept")
        } catch let error {
            os_log(.error, log: .network, "%s", error.localizedDescription)
        }
    }
}

extension OSLog {
    static var network = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "network")
}
