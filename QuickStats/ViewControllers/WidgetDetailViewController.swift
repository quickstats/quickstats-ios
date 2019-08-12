//
//  WidgetDetailViewController.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit
import os.log

private struct SectionGroup {
    let title: String
    let count: Int
}

class WidgetDetailViewController: UITableViewController, Storyboarded {
    fileprivate var tableSections = [
        SectionGroup(title: "Basic", count: 5),
        SectionGroup(title: "Actions", count: 1)
    ]

    var widget: Widget! {
        didSet {
            title = widget?.title
        }
    }

    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(clickDone))
    }

    @objc func clickDone() {
        dismiss(animated: true, completion: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableSections.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSections[section].count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        switch indexPath {
        case [0, 0]:
            cell.accessoryType = .none
            cell.textLabel?.text = "Title"
            cell.detailTextLabel?.text = widget.title
        case [0, 1]:
            cell.accessoryType = .none
            cell.textLabel?.text = "Type"
            cell.detailTextLabel?.text = widget.type.rawValue
        case [0, 2]:
            cell.accessoryType = .none
            cell.textLabel?.text = "Description"
            cell.detailTextLabel?.text = widget.description
        case [0, 3]:
            cell.accessoryType = .none
            cell.textLabel?.text = "Timestamp"
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            formatter.timeStyle = .full
            cell.detailTextLabel?.text = formatter.string(from: widget.timestamp)
        case [0, 4]:
            cell.accessoryType = .none
            cell.textLabel?.text = "Value"
            cell.detailTextLabel?.text = "\(widget.value)"
        case [1, 0]:
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "Samples"
            cell.detailTextLabel?.text = ""
        default:
            fatalError("Unknown section for \(indexPath)")
        }

        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSections[section].title
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath {
        case [1, 0]:
            return true
        default:
            return false
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [1, 0]:
            let view = SampleViewController.instantiate()
            view.widget = widget
            navigationController?.pushViewController(view, animated: true)
        default:
            print("unknown section")
        }
    }
}
