//
//  ViewController.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit
import os.log

class SubscriptionViewController: UICollectionViewController {
    private var subscriptions: [Widget]?
    private var refreshControl: UIRefreshControl!
    private let logger = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "SubscriptionViewController")

    @objc func loadData() {
        filterLoadData(filter: {_ in true})
    }

    func filterLoadData(filter: @escaping (Widget) -> Bool) {
        Widget.subscriptions { (widgets) in
            self.subscriptions = widgets.filter(filter).sorted { $0.timestamp < $1.timestamp }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

    @IBAction func clickOrganize(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Organize", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "All", style: .default) { (_) in
            self.filterLoadData {_ in true}
        })
        alert.addAction(UIAlertAction(title: "Filter Countdown", style: .default) { (_) in
            self.filterLoadData { $0.type == .Countdown }
        })
        alert.addAction(UIAlertAction(title: "Filter Location", style: .default) { (_) in
            self.filterLoadData { $0.type == .Location }
        })
        alert.addAction(UIAlertAction(title: "Filter Chart", style: .default) { (_) in
            self.filterLoadData { $0.type == .Chart }
        })
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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let username = Settings.shared.string(forKey: .username) else {
            let login = LoginViewController.instantiate()
            let nav = UINavigationController(rootViewController: login)
            nav.modalPresentationStyle = .formSheet
            present(nav, animated: true, completion: nil)
            return
        }
        os_log("Logged in as %s", log: logger, type: .debug, username)
        loadData()
    }
}

extension SubscriptionViewController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subscriptions?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withIdentifier: WidgetCollectionViewCell.self, for: indexPath)
        cell.widget = subscriptions?[indexPath.row]
        cell.sizeToFit()
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
        widgetDetail.widget = subscriptions?[indexPath.row]
        let navigation = UINavigationController(rootViewController: widgetDetail)
        navigation.modalPresentationStyle = .formSheet
        present(navigation, animated: true, completion: nil)
    }
}
