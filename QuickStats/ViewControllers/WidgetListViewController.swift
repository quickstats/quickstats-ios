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
    private var subscriptions: [Widget]?
    private var refreshControl: UIRefreshControl!
    private let logger = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "WidgetListViewController")

    @objc func loadData() {
        Widget.list { (widgets) in
            self.subscriptions = widgets
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
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
}

extension WidgetListViewController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subscriptions?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withIdentifier: WidgetCollectionViewCell.self, for: indexPath)
        cell.widget = subscriptions?[indexPath.row]
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
