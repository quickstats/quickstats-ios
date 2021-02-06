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
                        LazyVGrid(
                            columns: [.init(.adaptive(minimum: 150, maximum: 150))], spacing: 5
                        ) {
                            ForEach(filtered) { widget in
                                NavigationLink(destination: WidgetDetail(widget: widget)) {
                                    WidgetView(widget: widget)
                                        .minimumScaleFactor(0.1)
                                        .frame(width: 150, height: 150)
                                        .cornerRadius(10)
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
