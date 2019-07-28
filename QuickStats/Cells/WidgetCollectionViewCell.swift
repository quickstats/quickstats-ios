//
//  WidgetCollectionViewCell.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit

class WidgetCollectionViewCell: UICollectionViewCell {

    var widget: Widget? {
        didSet {
            titleLabel.text = widget?.title
            ownerLabel.text = widget?.owner
        }
    }

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var ownerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }

}
