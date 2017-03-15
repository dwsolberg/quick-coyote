//
//  CellTracking.swift
//
//  Created by David Solberg
//

import UIKit

extension UITableView {
    var arrayRegisteredCellIDs: [String]? {
        get {
            return objc_getAssociatedObject(self, &Keys.Table) as? [String]
        }
        set {
            objc_setAssociatedObject(self, &Keys.Table, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UICollectionView {
    var arrayRegisteredCellIDs: [String]? {
        get {
            return objc_getAssociatedObject(self, &Keys.Collection) as? [String]
        }
        set {
            objc_setAssociatedObject(self, &Keys.Collection, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// MARK: - Private

fileprivate struct Keys {
    static var Table = "dws_TableName"
    static var Collection = "dws_CollectionName"
}
