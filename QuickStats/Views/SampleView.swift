//
//  SampleView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/06.
//

import SwiftUI
import SwiftUICharts

struct SampleView: View {
    var widget: Widget

    var body: some View {
        VStack {
            Spacer()
            SampleFetch(widget: widget) { samples in
                TimelineChart(data: ChartData(from: samples.wrappedValue))
            }
            Spacer()
        }
    }
}

#if DEBUG
    struct SampleView_Previews: PreviewProvider {
        static var previews: some View {
            SampleView(widget: PreviewData.chart)
        }
    }
#endif

extension ChartData {
    public convenience init(from data: [Sample]) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short

        let values =
            data
            .sorted { $0.timestamp < $1.timestamp }
            .map { (formatter.string(from: $0.timestamp), $0.value) }

        self.init(values: values)
    }
}
