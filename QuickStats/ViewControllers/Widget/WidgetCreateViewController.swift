//
//  WidgetCreateViewController.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/11/04.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit

class WidgetCreateViewController: UITableViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(TextTableViewCell.self)
        tableView.register(ListTableViewCell.self)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath {
        case [0, 0]:
            let cell: TextTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.label = "Title"
            return cell
        case [0, 1]:
            let cell: ListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.label = "Type"
            cell.pickerData = WidgetType.allCases.map {$0.rawValue}
            return cell
        case [0, 2]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            return cell
        default:
            fatalError("Unknown index \(indexPath)")
        }
    }
}
