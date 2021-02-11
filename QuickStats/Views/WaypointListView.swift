//
//  WaypointListView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/11.
//

import SwiftUI

struct WaypointListView: View {
    var widget: Widget
    var body: some View {
        WidgetView(widget: widget)
            .frame(width: 200, height: 200)
            .cornerRadius(10)
        Divider()
        WaypointFetch(widget: widget) { waypoints in
            ForEach(waypoints.wrappedValue) { waypoint in
                HStack {
                    Text(waypoint.lat.description)
                    Text(waypoint.lon.description)
                    Spacer()
                    Text(waypoint.timestamp.description)
                }
            }
        }
        Spacer()
    }
}

#if DEBUG
    struct WaypointListView_Previews: PreviewProvider {
        static var previews: some View {
            WaypointListView(widget: PreviewData.chart)
        }
    }
#endif
