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
            MainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
