//
//  TodayViewController.swift
//  Pinned
//
//  Created by Paul Traylor on 2019/08/18.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit
import NotificationCenter

class PinnedViewController: UITableViewController, NCWidgetProviding {
    var widgets: [Widget]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(WidgetTableViewCell.self, forCellReuseIdentifier: "Cell")
        widgets = Settings.shared.cached(forKey: .cachedPinns)
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        let pinned = Settings.shared.array(forKey: .pinnedIDs) ?? []
        Widget.subscriptions { (subscriptions) in
            let filtered = subscriptions.filter { pinned.contains($0.id) }
            self.widgets = filtered.sorted { $0.timestamp < $1.timestamp }
            Settings.shared.set(self.widgets, forKey: .cachedPinns)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            completionHandler(NCUpdateResult.newData)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return widgets?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WidgetTableViewCell
        cell.widget = widgets![indexPath.row]
        return cell
    }
}
