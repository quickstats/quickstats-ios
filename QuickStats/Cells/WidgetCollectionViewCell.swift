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

    var widget: Widget? {
        didSet {
            titleLabel.text = widget?.title

            switch widget!.type {
            case .Countdown:
                let formatter = DateComponentsFormatter()
                formatter.allowedUnits = [.day, .hour, .minute, .second]
                formatter.unitsStyle = .positional
                formatter.zeroFormattingBehavior = .dropLeading
                let duration = widget!.timestamp.timeIntervalSinceNow
                valueLabel.text = formatter.string(from: duration)
            default:
                let formatter = NumberFormatter()
                formatter.groupingSeparator = " "
                formatter.numberStyle = .decimal
                valueLabel.text = formatter.string(for: widget!.value)
            }
        }
    }

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }

}
