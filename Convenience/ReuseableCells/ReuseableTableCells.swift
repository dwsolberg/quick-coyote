//
//  ReuseableCells.swift
//
//  Created by David Solberg
//

import Foundation

import UIKit

/// Code based off of: https://github.com/AliSoftware/Reusable

public protocol NibReusable  {
    static var nib: UINib { get }
    static var reuseIdentifier: String { get }
}

public extension NibReusable where Self: UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: self.baseClassName, bundle: Bundle(for: self))
    }
    
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

public extension NibReusable where Self: UITableViewHeaderFooterView {
    static var nib: UINib {
        return UINib(nibName: self.baseClassName, bundle: Bundle(for: self))
    }
    
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

fileprivate extension UIView {
    fileprivate static var baseClassName: String! {
        let namespacedClassName = NSStringFromClass(self) as NSString
        let baseClassName = namespacedClassName.components(separatedBy: ".").last
        return baseClassName!
    }
}

// MARK: - UITableView support for NibReusable -- Only works with Nib-based cells right now.

public extension UITableView {

    fileprivate final func registerReusableCellNib<T: UITableViewCell>(_ cellType: T.Type) where T: NibReusable {
        self.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: NibReusable {
        
        if self.arrayRegisteredCellIDs == nil {
            self.arrayRegisteredCellIDs = [String]()
        }
        if self.arrayRegisteredCellIDs?.contains(cellType.reuseIdentifier) == false {
            self.registerReusableCellNib(cellType)
            self.arrayRegisteredCellIDs?.append(cellType.reuseIdentifier)
        }
        
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly (nil or actual name) in nib."
            )
        }
        
        return cell
    }

    fileprivate final func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type) where T: NibReusable {
        self.register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T where T: NibReusable {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T else {
            return registerThenDequeueReusableHeaderFooterView(viewType)
        }
        return view
    }
    
    final func registerThenDequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T where T: NibReusable {
        self.registerReusableHeaderFooterView(viewType)
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T else {
            fatalError(
                "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) matching type \(viewType.self). "
                    + "Check that the reuseIdentifier is set properly (nil or actual name) in nib."
            )
        }
        return view
    }
    
    final func resizeHeaderView(_ view: UITableViewHeaderFooterView, inSection section: Int) {
        if let height = self.delegate?.tableView!(self, heightForHeaderInSection: section)  {
            let width = self.frame.width
            view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        } else {
            view.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: view.frame.height)
        }
        view.contentView.frame = view.frame
        view.setNeedsUpdateConstraints()
        view.layoutIfNeeded()
    }

}
