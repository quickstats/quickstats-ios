//
//  WaypointListViewController.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/10/14.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit

class WaypointListViewController: UITableViewController, Storyboarded {

    var widget: Widget! {
        didSet {
            title = "Waypoints for \(widget.title)"
        }
    }

    private var waypoints = [Waypoint]()

    override func viewDidLoad() {
        super.viewDidLoad()

        Waypoint.list(for: widget, limit: 100) { (waypoints) in
            // Sort Descending
            self.waypoints = waypoints.sorted { $0.timestamp > $1.timestamp }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waypoints.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let waypoint = waypoints[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let dateformat = DateFormatter()
        dateformat.dateStyle = .long
        dateformat.timeStyle = .long

        cell.textLabel?.text = dateformat.string(from: waypoint.timestamp)
        cell.detailTextLabel?.text = waypoint.state
        return cell
    }

}
