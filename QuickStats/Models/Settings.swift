//
//  Settings.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import Foundation
import KeychainAccess
import SwiftUI

typealias Login = String

class UserSettings: ObservableObject {
    private let keychain = Keychain(service: Bundle.main.bundleIdentifier!)

    @AppStorage("login") var login: Login? {
        willSet {
            objectWillChange.send()
        }
    }

    var password: String {
        set { try? keychain.set(newValue, key: "login") }
        get { try! keychain.get("login") ?? "" }
    }
}

extension Login {
    var username: String {
        return components(separatedBy: "@").first!
    }
    var domain: String {
        return components(separatedBy: "@").last!
    }
}
