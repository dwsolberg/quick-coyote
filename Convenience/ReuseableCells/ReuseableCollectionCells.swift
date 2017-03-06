//
//  ReuseableCollectionCells.swift
//
//  Created by David Solberg
//

import UIKit


public extension NibReusable where Self: UICollectionViewCell {
    static var nib: UINib {
        return UINib(nibName: self.baseClassName, bundle: Bundle(for: self))
    }
    
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }

    fileprivate static var baseClassName: String! {
        let namespacedClassName = NSStringFromClass(self) as NSString
        let baseClassName = namespacedClassName.components(separatedBy: ".").last
        return baseClassName!
    }
}

public extension UICollectionView {
    
    /**
     Register a NIB-Based `UICollectionViewCell` subclass (conforming to `NibReusable`)
     - parameter cellType: the `UICollectionViewCell` (`NibReusable`-conforming) subclass to register
     - seealso: `registerNib(_:,forCellWithReuseIdentifier:)`
     */
    fileprivate final func registerReusableCellNib<T: UICollectionViewCell>(_ cellType: T.Type) where T: NibReusable {
        self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /**
     Returns a reusable `UICollectionViewCell` object for the class inferred by the return-type
     - parameter indexPath: The index path specifying the location of the cell.
     - parameter cellType: The cell class to dequeue
     - returns: A `Reusable`, `UICollectionViewCell` instance
     - note: The `cellType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableCellWithReuseIdentifier(_:,forIndexPath:)`
     */
    final func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: NibReusable {

        // Automatically register any cells that haven't yet been registered.
        if self.arrayRegisteredCellIDs == nil {
            self.arrayRegisteredCellIDs = [String]()
        }
        if self.arrayRegisteredCellIDs?.contains(cellType.reuseIdentifier) == false {
            self.registerReusableCellNib(cellType)
            self.arrayRegisteredCellIDs?.append(cellType.reuseIdentifier)
        }
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
    
//    /**
//     Register a NIB-Based `UICollectionReusableView` subclass (conforming to `NibReusable`) as a Supplementary View
//     - parameter elementKind: The kind of supplementary view to create.
//     - parameter viewType: the `UIView` (`NibReusable`-conforming) subclass to register as Supplementary View
//     - seealso: `registerNib(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
//     */
//    final func registerNibReusableSupplementaryView<T: UITableViewHeaderFooterView>(_ elementKind: String, viewType: T.Type) where T: NibReusable {
//        self.register(viewType.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier)
//    }
//    
//    /**
//     Returns a reusable `UICollectionReusableView` object for the class inferred by the return-type
//     - parameter elementKind: The kind of supplementary view to retrieve.
//     - parameter indexPath:   The index path specifying the location of the cell.
//     - parameter viewType: The view class to dequeue
//     - returns: A `Reusable`, `UICollectionReusableView` instance
//     - note: The `viewType` parameter can generally be omitted and infered by the return type,
//     except when your type is in a variable and cannot be determined at compile time.
//     - seealso: `dequeueReusableSupplementaryViewOfKind(_:,withReuseIdentifier:,forIndexPath:)`
//     */
//    final func dequeueNibReusableSupplementaryView<T: UICollectionReusableView>
//        (_ elementKind: String, indexPath: IndexPath, viewType: T.Type = T.self) -> T where T: NibReusable {
//            
//            if self.arrayRegisteredCellIDs == nil {
//                self.arrayRegisteredCellIDs = NSMutableArray()
//            }
//            if self.arrayRegisteredCellIDs.contains(viewType) == false {
//                self.registerNibReusableSupplementaryView(elementKind, viewType: viewType)
//                self.arrayRegisteredCellIDs.add(viewType)
//            }
//            
//            let view = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier, for: indexPath)
//            guard let typedView = view as? T else {
//                fatalError(
//                    "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) matching type \(viewType.self). "
//                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
//                        + "and that you registered the supplementary view beforehand"
//                )
//            }
//            return typedView
//    }
}
