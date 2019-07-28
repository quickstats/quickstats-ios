//
//  WidgetDetailViewController.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit

enum WidgetDetailRows: Int {
    // Properties
    case title = 0
    case description
    case value
    case more
    case type
    case timestamp
    // Actions
    case samples
    case waypoints
    case notes
}

fileprivate struct SectionGroup {
    let title : String
    let list : [WidgetDetailRows]
}

class WidgetDetailViewController: UITableViewController, Storyboarded {

    fileprivate var sections = [
        SectionGroup(title: "Basic", list: [.title,.description, .timestamp, .value]),
        SectionGroup(title: "Actions", list: [.samples,.waypoints, .notes])
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
        return sections.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section].list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        switch section {
        case .title:
            cell.accessoryType = .none
            cell.textLabel?.text = "Title"
            cell.detailTextLabel?.text = widget.title
        case .value:
            cell.accessoryType = .none
            cell.textLabel?.text = "Value"
            cell.detailTextLabel?.text = "\(widget.value)"
        case .timestamp:
            cell.accessoryType = .none
            cell.textLabel?.text = "Timestamp"
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            formatter.timeStyle = .full
            cell.detailTextLabel?.text = formatter.string(from: widget.timestamp)
        case .description:
            cell.accessoryType = .none
            cell.textLabel?.text = "Description"
            cell.detailTextLabel?.text = widget.description
        case .samples:
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "Samples"
            cell.detailTextLabel?.text = ""
        default:
            cell.accessoryType = .none
            cell.textLabel?.text = "Unknown"
        }

        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    override func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        let section = sections[indexPath.section].list[indexPath.row]
        switch section {
        case .samples:
            return true
        default:
            return false
        }
    }
}
