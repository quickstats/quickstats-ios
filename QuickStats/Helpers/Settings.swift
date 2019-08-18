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

    func removeObject(forKey key: Settings.SettingsKeys) {
        removeObject(forKey: key.rawValue)
    }

    func cached<T: Decodable>(forKey key: Settings.SettingsKeys) -> T? {
        guard let data = value(forKey: key.rawValue) as? Data else { return nil}
        return try? PropertyListDecoder().decode(T.self, from: data)
    }

    func set<T: Encodable>(_ newValue: T, forKey key: Settings.SettingsKeys) {
        let data = try? PropertyListEncoder().encode(newValue)
        set(data, forKey: key.rawValue)
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
        case suite = "group.net.kungfudiscomonkey.quickstats"
        case username
        case server
        case pinnedIDs
        case cachedPinns
    }

    static var shared = UserDefaults.init(suiteName: SettingsKeys.suite.rawValue)!
    static var keychain = Keychain(service: SettingsKeys.suite.rawValue, accessGroup: SettingsKeys.suite.rawValue)

}
