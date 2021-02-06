//
//  DateView.swift
//  QuickStats
//
//  Created by Paul Traylor on 2021/02/06.
//

import SwiftUI

struct DateView: View {
    var date: Date

    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    var body: some View {
        Text(formatter.string(from: date))
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(date: .init())
    }
}
