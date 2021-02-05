//
//  IntervalView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import SwiftUI

struct IntervalView: View {
    var elapsed: TimeInterval

    var formatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }

    var body: some View {
        // Ensure that we always print the absolute value of our timer
        Text(formatter.string(from: elapsed > 0 ? elapsed : elapsed * -1)!)
    }

    init(elapsed: TimeInterval) {
        self.elapsed = elapsed
    }

    init(elapsed: [TimeInterval]) {
        self.elapsed = elapsed.reduce(0, +)
    }

    init(from start: Date, to end: Date) {
        self.elapsed = end.timeIntervalSince(start)
    }
}

struct IntervalView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalView(elapsed: TimeInterval(1337))
    }
}
