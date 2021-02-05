//
//  SettingsView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        NavigationView {
            List {
                Button("Logout", action: actionLogout)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationTitle("Settings")
    }

    func actionLogout() {
        settings.login = nil
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
