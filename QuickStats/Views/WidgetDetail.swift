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
                .padding()
            Divider()
            Text("Detail view Test")
            Spacer()
        }
        .navigationTitle(widget.title)
    }
}

//struct WidgetDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetDetail()
//    }
//}
