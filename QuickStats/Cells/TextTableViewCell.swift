//
//  TextTableViewCell.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/11/04.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell, ReusableCell {
    @IBOutlet private var labelView: UILabel!
    @IBOutlet private var textView: UITextField!

    var label: String? {
        didSet {
            labelView.text = label
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
