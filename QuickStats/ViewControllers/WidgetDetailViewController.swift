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
        SectionGroup(title: "Actions", count: 4)
    ]

    var timer: Timer?
    var countdown: UITableViewCell?
    var countdownFormat = Formats.Countdown
    var pinnedItems: [String]!

    var widget: Widget! {
        didSet {
            title = widget?.title

            if widget.type == .Countdown {
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: updateCountdown(timer:))
            } else {
                timer?.invalidate()
            }
        }
    }

    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(clickDone))
        pinnedItems = Settings.shared.array(forKey: .pinnedIDs) ?? []
    }

    @objc func clickDone() {
        dismiss(animated: true, completion: nil)
    }

    func updateCountdown(timer: Timer) {
        let duration = widget!.timestamp.timeIntervalSinceNow
        if duration > 0 {
            countdown?.detailTextLabel?.text = countdownFormat.string(from: duration)
            countdown?.detailTextLabel?.textColor = Colors.TimerPending
        } else {
            countdown?.detailTextLabel?.text = countdownFormat.string(from: duration * -1)
            countdown?.detailTextLabel?.textColor = Colors.TimerOverdue
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableSections.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSections[section].count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.detailTextLabel?.textColor = UIColor.black

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
            countdown = widget.type == .Countdown ? cell : nil
            cell.detailTextLabel?.text = "\(widget.value)"
        case [1, 0]:
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "Samples"
            cell.detailTextLabel?.text = ""
        case [1, 1]:
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "Waypoints"
            cell.detailTextLabel?.text = ""
        case [1, 2]:
            cell.accessoryType = pinnedItems.contains(widget.id) ? .checkmark : .none
            cell.textLabel?.text = pinnedItems.contains(widget.id) ? "Unpin" : "Pin"
            cell.detailTextLabel?.text = ""
        case [1, 3]:
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "Subscribe"
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
        case [1, 1]:
            let view = WaypointListViewController.instantiate()
            view.widget = widget
            navigationController?.pushViewController(view, animated: true)
        case [1, 2]:
            if pinnedItems.contains(widget.id) {
                pinnedItems = pinnedItems.filter {$0 != widget.id}
            } else {
                pinnedItems.append(widget.id)
            }
            Settings.shared.set(pinnedItems, forKey: .pinnedIDs)
            tableView.reloadData()
        case [1, 3]:
            widget.subscribe { (widget) in
                print(widget)
            }
        default:
            print("unknown section")
        }
    }
}
