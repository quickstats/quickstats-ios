//
//  ListTableViewCell.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/11/04.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell, ReusableCell {

    @IBOutlet var labelView: UILabel!
    @IBOutlet var pickerView: UIPickerView!

    var label: String? {
        didSet {
            labelView.text = label
        }
    }

    var pickerData = [String]() {
        didSet {
            pickerView.reloadAllComponents()
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

extension ListTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
