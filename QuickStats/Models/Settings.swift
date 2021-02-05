//
//  Settings.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import Foundation
import SwiftUI

typealias Login = String

class UserSettings: ObservableObject {
    @AppStorage("login") var login: Login?
}

extension Login {
    var username: String {
        return components(separatedBy: "@").first!
    }
    var domain: String {
        return components(separatedBy: "@").last!
    }
}
