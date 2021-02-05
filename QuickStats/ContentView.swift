//
//  ContentView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        if settings.login == nil {
            LoginView()
        } else {
            TabView {
                MainView()
                    .tag(0)
                    .tabItem { Label("Main", systemImage: "house") }
                SettingsView()
                    .tag(1)
                    .tabItem { Label("Settings", systemImage: "gear") }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
