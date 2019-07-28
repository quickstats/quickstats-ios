//
//  Settings.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import Foundation

extension UserDefaults {
    func string(forKey key: Settings.SettingsKeys) -> String? {
        return string(forKey: key.rawValue)
    }
    func set(_ newValue: String, forKey key: Settings.SettingsKeys) {
        set(newValue, forKey: key.rawValue)
    }
}

class Settings {
    enum SettingsKeys: String {
        case suite = "net.kungfudiscomonkey.quickstats"
        case username = "username"
        case password = "password"
    }

    static var shared = UserDefaults.init(suiteName: SettingsKeys.suite.rawValue)!
}
