//
//  SampleViewController.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit

class SampleViewController: UITableViewController, Storyboarded {

    var widget: Widget! {
        didSet {
            title = "Samples for \(widget.title)"
        }
    }

    private var samples = [Sample]()

    override func viewDidLoad() {
        super.viewDidLoad()

        Sample.list(for: widget, limit: 100) { (samples) in
            // Sort Descending
            self.samples = samples.sorted { $0.timestamp > $1.timestamp }
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
        return samples.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sample = samples[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let dateformat = DateFormatter()
        dateformat.dateStyle = .long
        dateformat.timeStyle = .long

        let numberformat = NumberFormatter()

        cell.textLabel?.text = dateformat.string(from: sample.timestamp)
        cell.detailTextLabel?.text = numberformat.string(for: sample.value)
        return cell
    }

}
