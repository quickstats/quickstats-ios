//
//  WidgetCollectionViewCell.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit
import SDWebImage

class WidgetCollectionViewCell: UICollectionViewCell {
    var formatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .dropLeading
        return formatter
    }

    var timer: Timer?
    var widget: Widget? {
        didSet {
            titleLabel.text = widget?.title

            switch widget!.type {
            case .Countdown:
                timer = Timer.scheduledTimer(withTimeInterval: .init(1), repeats: true, block: updateCounter(timer:))
                updateCounter(timer: timer!)
            default:
                timer?.invalidate()
                let formatter = NumberFormatter()
                formatter.groupingSeparator = " "
                formatter.numberStyle = .decimal
                valueLabel.text = formatter.string(for: widget!.value)
                valueLabel.textColor = UIColor.black
            }
        }
    }

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!

    func updateCounter(timer: Timer) {
        let duration = widget!.timestamp.timeIntervalSinceNow
        if duration > 0 {
            valueLabel.text = formatter.string(from: duration)
            valueLabel.textColor = UIColor.blue
        } else {
            valueLabel.text = formatter.string(from: duration * -1)
            valueLabel.textColor = UIColor.red
        }

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }

    deinit {
        timer?.invalidate()
    }

}
