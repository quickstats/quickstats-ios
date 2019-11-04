//
//  WidgetListViewController.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit
import os.log

class WidgetListViewController: UICollectionViewController {
    private var filteredWidgets = [Widget]()
    private var allWidgets = [Widget]()

    @IBOutlet var queryToggle: UISegmentedControl!
    private var refreshControl: UIRefreshControl!
    private let logger = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "WidgetListViewController")
    private var selectedFilter: WidgetType?

    @objc func loadData() {
        refreshControl.beginRefreshing()
        switch queryToggle.selectedSegmentIndex {
        case 0:

            Widget.subscriptions { (widgets) in
                self.allWidgets = widgets.sorted { $0.timestamp < $1.timestamp }
                self.setFilter(filter: self.selectedFilter)
            }
        case 1:
            Widget.list { (widgets) in
                self.allWidgets = widgets.sorted { $0.timestamp < $1.timestamp }
                self.setFilter(filter: self.selectedFilter)
            }
        default:
            fatalError("Unknown index for selector")
        }
    }

    func setFilter(filter: WidgetType?) {
        if let filteredBy = filter {
            filteredWidgets = allWidgets.filter { $0.type == filteredBy}
        } else {
            filteredWidgets = allWidgets
        }

        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    @IBAction func clickOrganize(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Organize", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "All", style: .default) { (_) in
            self.setFilter(filter: nil)
        })

        for type in WidgetType.allCases {
            alert.addAction(UIAlertAction(title: "Filter \(type)", style: .default) { (_) in
                self.setFilter(filter: type)
            })
        }

        alert.popoverPresentationController?.barButtonItem = sender
        alert.popoverPresentationController?.sourceView = collectionView
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerReusableCell(tableViewCell: WidgetCollectionViewCell.self)

        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(loadData), for: UIControl.Event.valueChanged)
        collectionView!.addSubview(refreshControl)

        loadData()
    }

    @IBAction func toggleSelection(_ sender: UISegmentedControl) {
        loadData()
    }

}

extension WidgetListViewController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredWidgets.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withIdentifier: WidgetCollectionViewCell.self, for: indexPath)
        cell.widget = filteredWidgets[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 10 Gives us our border around the edges
        let width = (UIScreen.main.bounds.width - 20) / 3
        os_log("Collection size: %f.2", log: logger, type: .debug, width)

        if width > 128 {
            return CGSize(width: 128, height: 128)
        }
        return CGSize(width: width, height: width)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let widgetDetail = WidgetDetailViewController.instantiate()
        widgetDetail.widget = filteredWidgets[indexPath.row]
        let navigation = UINavigationController(rootViewController: widgetDetail)
        navigation.modalPresentationStyle = .formSheet
        present(navigation, animated: true, completion: nil)
    }
}
