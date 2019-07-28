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

    @objc func loadData() {
        Widget.subscriptions { (widgets) in
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let username = Settings.shared.string(forKey: .username) else {
            let login = LoginViewController.instantiate()
            let nav = UINavigationController(rootViewController: login)
            nav.modalPresentationStyle = .formSheet
            present(nav, animated: true, completion: nil)
            return
        }
        os_log(.debug, "Logged in as ", username)
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
        return CGSize(width: 128, height: 128)
    }
}
