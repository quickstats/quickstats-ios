//
//  MainView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import Combine
import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            WidgetFetcher { widgets in
                ScrollView {
                    LazyVGrid(columns: [.init(.adaptive(minimum: 200, maximum: 300))]) {
                        ForEach(widgets) { widget in
                            WidgetView(widget: widget)
                                .frame(minWidth: 200, maxWidth: .infinity, minHeight: 200)
                                .cornerRadius(10)
                                .padding()
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationTitle("Home")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
