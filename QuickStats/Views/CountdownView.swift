//
//  CountdownView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/05.
//

import SwiftUI

struct CountdownView: View {
    @EnvironmentObject var settings: UserSettings

    var date: Date

    @State private var color = Color.white
    @State private var elapsed = TimeInterval()

    private func tick(tick: Date) {
        elapsed = Date().timeIntervalSince(date).rounded()

        switch elapsed {
        case _ where elapsed < 0:
            color = .green
        case _ where elapsed > 0:
            color = .red
        default:
            color = .blue
        }
    }

    var body: some View {
        IntervalView(elapsed: elapsed)
            .foregroundColor(color)
            .onReceive(settings.timer, perform: tick)
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(date: Date()).previewLayout(.sizeThatFits)
    }
}
