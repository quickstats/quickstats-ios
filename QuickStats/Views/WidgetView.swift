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
                .lineLimit(2)
            Text(widget.description)
                .font(.caption)
            Spacer()

            switch widget.type {
            case .countdown:
                CountdownView(date: widget.timestamp)
                    .font(.title)
                    .lineLimit(1)
            default:
                Text(widget.value.description)
                    .font(.title)
                    .lineLimit(1)
                DateView(date: widget.timestamp)
                    .lineLimit(1)
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .border(widget.color, width: 5)

    }
}

#if DEBUG
    struct WidgetView_Previews: PreviewProvider {
        static var previews: some View {
            WidgetView(widget: PreviewData.chart)
        }
    }
#endif
