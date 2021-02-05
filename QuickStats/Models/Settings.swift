//
//  Settings.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import Foundation
import SwiftUI

class UserSettings: ObservableObject {
    @AppStorage("login") var login: String?
}
