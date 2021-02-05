//
//  MainView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import Combine
import SwiftUI

struct WidgetFilter<Content: View>: View {
    @State private var selectedFilter: WidgetType?
    @Binding var widgets: [Widget]
    var content: ([Widget]) -> Content

    var body: some View {
        VStack {
            Picker("Filter \(selectedFilter.debugDescription)", selection: $selectedFilter) {
                Text("All").tag(WidgetType?.none)
                ForEach(WidgetType.allCases) { type in
                    Text(type.rawValue.capitalized).tag(WidgetType?.some(type))
                }
            }
            .pickerStyle(MenuPickerStyle())

            content(widgets.filter { selectedFilter == nil ? true : selectedFilter == $0.type })
        }
    }
}

struct MainView: View {

    var body: some View {
        NavigationView {
            WidgetFetcher { widgets in
                WidgetFilter(widgets: widgets) { filtered in
                    ScrollView {
                        LazyVGrid(columns: [.init(.adaptive(minimum: 200, maximum: 300))]) {
                            ForEach(filtered) { widget in
                                NavigationLink(destination: WidgetDetail(widget: widget)) {
                                    WidgetView(widget: widget)
                                        .frame(width: 200, height: 200)
                                        .cornerRadius(10)
                                        .padding()
                                }
                            }
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
