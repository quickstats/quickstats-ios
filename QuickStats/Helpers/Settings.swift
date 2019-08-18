//
//  Settings.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import Foundation
import KeychainAccess

extension UserDefaults {
    func string(forKey key: Settings.SettingsKeys) -> String? {
        return string(forKey: key.rawValue)
    }
    func array(forKey key: Settings.SettingsKeys) -> [String]? {
        return stringArray(forKey: key.rawValue)
    }

    func set(_ newValue: String, forKey key: Settings.SettingsKeys) {
        set(newValue, forKey: key.rawValue)
    }

    func set(_ newValue: [String]?, forKey key: Settings.SettingsKeys) {
        set(newValue, forKey: key.rawValue)
    }
}

extension Keychain {
    func string(forKey key: Settings.SettingsKeys) -> String? {
        return try? getString(key.rawValue)
    }

    func set(_ newValue: String, forKey key: Settings.SettingsKeys) {
        try? set(newValue, key: key.rawValue)
    }
}

class Settings {
    enum SettingsKeys: String {
        case suite = "net.kungfudiscomonkey.quickstats"
        case username
        case server
        case pinnedItems
    }

    static var shared = UserDefaults.init(suiteName: SettingsKeys.suite.rawValue)!
    static var keychain = Keychain(service: SettingsKeys.suite.rawValue)
}
