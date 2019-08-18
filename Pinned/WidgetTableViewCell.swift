//
//  WidgetTableViewCell.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/08/18.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit

class WidgetTableViewCell: UITableViewCell {
    let countdownFormat = Formats.Countdown
    let numberFormat = Formats.Number

    var timer: Timer?
    var widget: Widget! {
        didSet {
            textLabel?.text = widget.title
            timer?.invalidate()

            if widget.type == .Countdown {
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: updateCountdown)
                updateCountdown(timer: timer!)
            } else {
                detailTextLabel?.text = numberFormat.string(for: widget.value)
                detailTextLabel?.textColor = UIColor.black
            }

        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateCountdown(timer: Timer) {

        let duration = widget!.timestamp.timeIntervalSinceNow
        if duration > 0 {
            detailTextLabel?.text = countdownFormat.string(from: duration)
            detailTextLabel?.textColor = Colors.TimerPending
        } else {
            detailTextLabel?.text = countdownFormat.string(from: duration * -1)
            detailTextLabel?.textColor = Colors.TimerOverdue
        }

    }

}
