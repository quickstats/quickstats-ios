//
//  Constants.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/08/18.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit


class Colors {
    static let TimerOverdue = UIColor.red
    static let TimerPending = UIColor.blue
}

class Formats {
    static var Countdown: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .dropLeading
        return formatter
    }

    static var Number: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }
}
