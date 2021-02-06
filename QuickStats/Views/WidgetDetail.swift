//
//  WidgetDetail.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import SwiftUI

struct WidgetDetail: View {
    var widget: Widget
    var body: some View {
        VStack {
            WidgetView(widget: widget)
                .frame(width: 200, height: 200)
                .cornerRadius(10)
            Divider()
            Text("Detail view Test")
            Spacer()
            List {
                if widget.type == .chart {
                    NavigationLink(destination: SampleView(widget: widget)) {
                        Label("Samples", systemImage: "chart.bar")
                    }
                }
            }
        }
        .navigationTitle(widget.title)
    }
}

//struct WidgetDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetDetail()
//    }
//}
