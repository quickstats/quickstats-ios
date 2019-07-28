//
//  CollectionView+RegisterXib.swift
//  QuickStats
//
//  Created by Paul Traylor on 2019/07/28.
//  Copyright © 2019 Paul Traylor. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerReusableCell<T: UICollectionViewCell>(tableViewCell: T.Type) {
        let fullName = NSStringFromClass(T.self)
        let className = fullName.components(separatedBy: ".")[1]
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(withIdentifier: T.Type, for indexPath: IndexPath) -> T {
        let fullName = NSStringFromClass(withIdentifier)
        let className = fullName.components(separatedBy: ".")[1]
        return dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as! T
    }
}
