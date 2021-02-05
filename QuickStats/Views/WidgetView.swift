//
//  WidgetView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import SwiftUI

struct WidgetView: View {
    var widget: Widget

    var body: some View {
        VStack(alignment: .center) {
            Text(widget.title)
                .font(.title2)
            Text(widget.description)
                .font(.caption)
            Spacer()
            Text(widget.value.description)
                .font(.title)
        }
        .minimumScaleFactor(0.5)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .border(widget.color, width: 5)
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(
            widget: .init(
                id: .init(), title: "test", description: "description", value: 100, type: .streak))
    }
}
